//
//  ViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 9/26/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import CoreMotion

class DoAssignmentViewController: UIViewController{

    // Exercise's ID
    var exerciseID:Int = 0
    // CurrentQuestion's information
    var assignmentQuestionVM:AssignmentQuestionViewModel?
    
    // The list of all words in current question
    var words:[String]?
    // The list of all wordItems
    var wordItems = [WordItem]()
    
    // MotionManager
    var motionManager = CMMotionManager()
    
    // Movements
    // 20 time per second
    var samplingFrequency:Int = 20
    
    var isTappingNow:Bool = false
    
    var movementCollection = [Movement]()
    var movementCollectionCurrentIndex:Int = 0
    
    var deviceAccelerationCollection = [DeviceAcceleration]()
    var deviceAccelerationCollectionCurrentIndex:Int = 0
    
    // This factor records the original position value of pointer in the UIView(WordItem)
    // It will be used in panGesetureRecongnizerHandler function
    var pointerTapSingleBeganPositionInWordItem:CGPoint?
    
    // Grouping
    var pointerMakeGroupBeganPositionInMainView:CGPoint?
    var pointerTapGroupBeganPositionInRectSelectionView:CGPoint?
    
    // Timer
    var timer:Timer?
    var currentMillisecondTime:Int = 0
    
    // Date
    var currentQuestionStartDate:Date?
    var currentQuestionEndDate:Date?
    
    // AlertController
    var alertDialog:UIAlertController?
    
    // NVActivityIndicatorView
    var activityIndicatorOverlayView:ActivityIndicatorOverlayView?
    
    // GroupSelectionView
    var rectSelectionView:RectSelectionView?
    
    // GroupBehaviorRecongnizer
    var makeGroupBehaviorPanGestureRecongnizer:UIPanGestureRecognizer?
    var tapGroupBehaviorPanGestureReconginzer:UIPanGestureRecognizer?
    // For cancel
    var mainViewTapGestureReconginzer:UITapGestureRecognizer?
    
    // Operation State
    var isGroupingNow:Bool = false
    
    // Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //
        showQuestionInfo()
        generateWordItems()
        arrangeWordItems()
 
        // AlertDialog
        alertDialog = UIAlertController(title: "確認", message: "今の解答でよろしいですか?", preferredStyle: .alert)
        alertDialog!.addAction(UIAlertAction(title: "はい", style:.default, handler: alertActionHandler(alertAction:)))
        alertDialog!.addAction(UIAlertAction(title: "いいえ", style:.cancel, handler: alertActionHandler(alertAction:)))
        
        // RectSelectionView
        rectSelectionView = RectSelectionView()
        //mainView.addSubview(rectSelectionView!)
        
        // MakeGroupBehaviorPanGestureRecongnizer
        makeGroupBehaviorPanGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(makeGroupBehaviorPanGestureRecongnizerHandler(recongnizer:)))
        mainView.addGestureRecognizer(makeGroupBehaviorPanGestureRecongnizer!)
        mainView.isUserInteractionEnabled = true
        
        // TapGroupBehaviorPanGestureRecongnizer
        tapGroupBehaviorPanGestureReconginzer = UIPanGestureRecognizer(target: self, action: #selector(tapGroupBehaviorPanGestureRecongnizerHandler(recongnizer:)))
        rectSelectionView!.addGestureRecognizer(tapGroupBehaviorPanGestureReconginzer!)
        rectSelectionView!.isUserInteractionEnabled = true
        
        // MainViewTapGestureReconginzer
        mainViewTapGestureReconginzer = UITapGestureRecognizer(target: self, action: #selector(mainViewTapGestureRecongnizerHandler(recongnizer:)))
        mainView.addGestureRecognizer(mainViewTapGestureReconginzer!)
        mainView.isUserInteractionEnabled = true
        
        // ActivityIndicatorOverlayView
        activityIndicatorOverlayView = ActivityIndicatorOverlayView()
        activityIndicatorOverlayView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        // Acceleration
        if(motionManager.isAccelerometerAvailable){
            motionManager.accelerometerUpdateInterval = 1.0/Double(samplingFrequency)
            
            motionManager.startAccelerometerUpdates()
        }
        
        // Timer controls sampling
        startSampling()
        
    }
    
    private func startSampling(){
        
        // Timer
        timer = Timer.scheduledTimer(timeInterval: 1.0/Double(samplingFrequency), target: self, selector: #selector(samplingHandler), userInfo: nil, repeats: true)
        
        currentQuestionStartDate = Date()
        
        currentMillisecondTime = 0
    }
    
    private func stopSmapling(){
        
        if(timer != nil){
            timer?.invalidate()
            timer = nil
        }
        
        currentQuestionEndDate = Date()
    }
    
    private func updateTime(){
        currentMillisecondTime += 1000/samplingFrequency
        
    }
    
    @objc private func samplingHandler(){
        
        if(isTappingNow){
            
            // StoreMovement is handled by gesture
            storeDeviceAcceleration()
        }
        
        updateTime()
    }
    
    private func loadQuestion(){

        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ActiveUserInfo.getToken(),
            ]
        
        let parameters:Parameters = [
            "exerciseID":exerciseID,
            ]
        
        // Request data from remote server
        AlamofireManager.sharedSessionManager.request(RemoteServiceManager.domain + "/MobileApplication/GetNextQuestion", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON(completionHandler:
            {
                response in
                
                switch(response.result){
                    
                case .success(let json):
                    
                    // If return No-Content(204), take the user to the AssignmentResult page
                    if(response.response?.statusCode == 204){
                        
                        self.performSegue(withIdentifier: "GenerateAssignmentResult", sender: self.exerciseID)
                    }
                    else{
                        
                        let dict = json as! [String:Any]
                        
                        self.assignmentQuestionVM = AssignmentQuestionViewModel(dict: dict)
                        
                        self.showQuestionInfo()
                        self.generateWordItems()
                        self.arrangeWordItems()
                        
                        self.startSampling()
                        
                    }
                    
                    break
                    
                case .failure(let json):
                    
                    let dict = json as! [String:Any]
                    print(dict["message"] as! String)
                    
                    break
                }
                
        })
    }
    
    private func showQuestionInfo(){
        
        // Set layout
        numberLabel.text = "\(assignmentQuestionVM?.currentNumber ?? 0)"
        questionLabel.text = assignmentQuestionVM?.sentenceJP
        answerLabel.text = "-"
    }
    
    private func generateWordItems(){
        
        // Clear
        clearCurrentQuestion()
        
        // Generate words from division
        words = assignmentQuestionVM?.division.components(separatedBy: "|")
        
        for index in 0...words!.count - 1{
            
            let topDistance:CGFloat = 20.0
            
            let singleWordItem = WordItem()
            
            singleWordItem.index = index
            singleWordItem.textLabel.text = words?[index]
            singleWordItem.frame = CGRect(x: 0, y: 0, width: singleWordItem.textLabel.intrinsicContentSize.width + 40.0, height: singleWordItem.textLabel.intrinsicContentSize.height + 10.0 + topDistance)

            wordItems.append(singleWordItem)
            
            singleWordItem.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(tapSingleBehaviorPanGestureRecongnizerHandler(recongnizer:))))
            singleWordItem.isUserInteractionEnabled = true
            
        }
    }

    private func arrangeWordItems(){
        
        let horizontalPadding:CGFloat = 10.0
        let verticalPadding:CGFloat = 10.0
        
        let wordItemHeight = wordItems[0].frame.height
        
        let containerLength = mainView.frame.width
        let containerHeight = mainView.frame.height
        var lines = [[WordItem]]()
        var currentLine = [WordItem]()
        var currentLineLength:CGFloat = 0.0
        
        for index in 0...wordItems.count - 1{
            
            if(currentLineLength + wordItems[index].frame.width + horizontalPadding > containerLength){
                
                lines.append(currentLine)
                currentLine.removeAll()
                currentLineLength = 0.0
            }

            currentLine.append(wordItems[index])
            currentLineLength = currentLineLength + horizontalPadding + wordItems[index].frame.width
            
            // when over
            if(index >= wordItems.count - 1)
            {
                lines.append(currentLine)
                currentLine.removeAll()
                currentLineLength = 0.0
            }
            
        }
        
        // Arrage
        
        for lineNumber in 0...lines.count - 1{
            var currentXPosition:CGFloat = 0.0
            
            for wordItemNumber in 0...lines[lineNumber].count - 1{
                
                lines[lineNumber][wordItemNumber].frame = CGRect(x: currentXPosition + horizontalPadding, y: containerHeight - CGFloat(lines.count - lineNumber) * (wordItemHeight + verticalPadding), width: lines[lineNumber][wordItemNumber].frame.width, height: lines[lineNumber][wordItemNumber].frame.height)

                
                mainView.addSubview(lines[lineNumber][wordItemNumber])
                
                currentXPosition = currentXPosition + horizontalPadding + lines[lineNumber][wordItemNumber].frame.width
                
            }
        }
    }
    
    private func clearCurrentQuestion(){
        
        for remainedWordItem in wordItems{
            remainedWordItem.removeFromSuperview()
        }
        
        wordItems.removeAll()
        
        movementCollection.removeAll()
        movementCollectionCurrentIndex = 0
        
        deviceAccelerationCollection.removeAll()
        deviceAccelerationCollectionCurrentIndex = 0
    }
    
    // These functions are related to order number
    // Show/Hide order numbers when user is tapping on WordItem
    func showOrderNumberForWordItems(){
        for index in 0...wordItems.count - 1 {
            wordItems[index].showOrderNumber()
        }
    }
    
    func hideOrderNumberForWordItems(){
        for index in 0...wordItems.count - 1 {
            wordItems[index].hideOrderNumber()
        }
    }
    
    // Generate correct order numbers based on the current arrangement
    func generateOrderNumber(){
        let sortedWordItems = wordItems.sorted(by: { $0.frame.minX < $1.frame.minX })
        
        for index in 0...sortedWordItems.count - 1 {
            sortedWordItems[index].orderNumberLabel.text = String(index + 1)
        }

    }
    
    func generateAnswer(){
        
        var answer:String = ""
        
        // Sort WordItems by their x-postion
        let sortedWordItems = wordItems.sorted(by: { $0.frame.minX < $1.frame.minX })
        
        for index in 0...sortedWordItems.count - 1{
            
            if(index == 0){
                answer += sortedWordItems[index].textLabel.text!
            }
            else{
                answer += " " + sortedWordItems[index].textLabel.text!
            }
        }
        
        // Format
        answer += "."
        answer.capitalizeFirstLetter()
        
        answerLabel.text = answer
    }
    
    private func storeDeviceAcceleration(){
        
        let accelerationX:Float = Float(motionManager.accelerometerData?.acceleration.x ?? 0)
        let accelerationY:Float = Float(motionManager.accelerometerData?.acceleration.y ?? 0)
        let accelerationZ:Float = Float(motionManager.accelerometerData?.acceleration.z ?? 0)
        
        deviceAccelerationCollection.append(DeviceAcceleration(index:deviceAccelerationCollectionCurrentIndex, time:currentMillisecondTime,x: accelerationX, y: accelerationY, z: accelerationZ))
        
        deviceAccelerationCollectionCurrentIndex += 1
    }
    
    private func storeMovement(position:CGPoint,movementState:MovementState,targetElement:Int){
        
        if(!movementCollection.isEmpty){
            
            if(movementState == .tapSingleMove && currentMillisecondTime >= movementCollection.last!.time + 1000/samplingFrequency ){
                return
            }
        }
        

        let movement = Movement(index: movementCollectionCurrentIndex, state: movementState.rawValue, targetElement:targetElement, time: currentMillisecondTime, xPosition: Int(position.x), yPosition: Int(position.y))
        
        movementCollection.append(movement)
        movementCollectionCurrentIndex += 1
    
    }
    
    
        
    // WordItem's dragging behavior
    @objc private func tapSingleBehaviorPanGestureRecongnizerHandler(recongnizer:UIPanGestureRecognizer){
        
        // Get triggered view
        let triggeredView = recongnizer.view as! WordItem
        
        switch recongnizer.state {
            
        // How it works -
        // Firstly when tap begins, record the current position of finger in the tapped WordItem(Not the mainView)
        // So we got the relative position between tapped WordItem and user's finger
        // Then when every movement occurs, see where the user's finger is, get its current postion in mainView
        // By current position of user's finger in mainView and the relative position we got above, we could calculate where the tapped WordItem should be and move it
            
        // Formula -
        // ThePositionOfWordItem(Where it should be now) = CurrentPositionOfFinger(In mainView) + ThePositionWhenFingerFirstTapOnTheWordItem(Positive or negative)
            
        case .began:
            
            // If RectSelection exists, cancel it
            rectSelectionView!.cancelAction()
            rectSelectionView!.removeFromSuperview()
            
            
            // Record the current position in the tapped WordItem
            pointerTapSingleBeganPositionInWordItem = recongnizer.location(in: triggeredView)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            showOrderNumberForWordItems()
            
            // Store
            storeMovement(position: recongnizer.location(in: mainView), movementState: MovementState.tapSingleBegin,targetElement:triggeredView.index)
            
            isTappingNow = true
            
            break;
            
        case .changed:
            
            // Get finger's current postion in mainView
            let pointerCurrentPositionInMainView = recongnizer.location(in: mainView)
            let triggeredViewSize = triggeredView.frame.size
            
            // Adjust the postion of WordItem
            triggeredView.frame = CGRect(x: pointerCurrentPositionInMainView.x - pointerTapSingleBeganPositionInWordItem!.x, y: pointerCurrentPositionInMainView.y - pointerTapSingleBeganPositionInWordItem!.y, width: triggeredViewSize.width, height: triggeredViewSize.height)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            
            // Store
            storeMovement(position: recongnizer.location(in: mainView), movementState: MovementState.tapSingleMove,targetElement:triggeredView.index)
            
            break;
            
        case .ended:
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            hideOrderNumberForWordItems()

            // Store
            storeMovement(position: recongnizer.location(in: mainView), movementState: MovementState.tapSingleEnd,targetElement:triggeredView.index)
            
            isTappingNow = false
            
            break;
        
        default:
            break;
        }
        
    }
    
    // Make group selection's behavior
    @objc private func makeGroupBehaviorPanGestureRecongnizerHandler(recongnizer:UIPanGestureRecognizer){
        
        switch recongnizer.state {
            
        case .began:
            
            // If RectSelection exists, cancel it
            rectSelectionView!.cancelAction()
            rectSelectionView!.removeFromSuperview()
            
            // RectSelectionView
            mainView.addSubview(rectSelectionView!)
            rectSelectionView?.layer.zPosition = 1
            rectSelectionView!.show()
            
            // Record the current position in the tapped WordItem
            pointerMakeGroupBeganPositionInMainView = recongnizer.location(in: mainView)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            showOrderNumberForWordItems()
            
            // Selection
            rectSelectionView!.selectWordItem(wordItemCollection: wordItems)
            
            isTappingNow = true
            
            break;
            
        case .changed:
            
            // Get finger's current postion in mainView
            let pointerCurrentPositionInMainView = recongnizer.location(in: mainView)
            
            // Set RectSelectionView's frame
            let rect = CGRect(x:min(pointerMakeGroupBeganPositionInMainView!.x, pointerCurrentPositionInMainView.x),
                              y:min(pointerMakeGroupBeganPositionInMainView!.y, pointerCurrentPositionInMainView.y),
                              width:fabs(pointerMakeGroupBeganPositionInMainView!.x - pointerCurrentPositionInMainView.x),
                              height:fabs(pointerMakeGroupBeganPositionInMainView!.y - pointerCurrentPositionInMainView.y));
            
            rectSelectionView!.setFrame(rect: rect)
            
            // Selection
            rectSelectionView!.selectWordItem(wordItemCollection: wordItems)
 
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            
            break;
            
        case .ended:
            
            // Selection
            rectSelectionView!.selectWordItem(wordItemCollection: wordItems)
            
            if(rectSelectionView!.isEmptySelection){
                
                rectSelectionView!.cancelAction()
                rectSelectionView!.removeFromSuperview()
            }
            
            rectSelectionView!.hide()
            
            print(rectSelectionView!.generateSelectedTargetElementIndexString())
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            hideOrderNumberForWordItems()
            
            
            isTappingNow = false
            
            break;
            
        default:
            break;
        }
        
    }
    
    // Tap group selection's behavior
    @objc private func tapGroupBehaviorPanGestureRecongnizerHandler(recongnizer:UIPanGestureRecognizer){
        
        // Get triggered view
        let triggeredView = recongnizer.view as! RectSelectionView
        
        switch recongnizer.state {
            
        case .began:
            
            // Record the current position in the tapped WordItem
            pointerTapGroupBeganPositionInRectSelectionView = recongnizer.location(in: triggeredView)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            showOrderNumberForWordItems()
            
            isTappingNow = true
            
            break;
            
        case .changed:
            
            // Get finger's current postion in mainView
            let pointerCurrentPositionInMainView = recongnizer.location(in: mainView)
            let triggeredViewSize = triggeredView.frame.size
            
            // Get original position
            let orgRectSelectionViewRect = triggeredView.frame
            
            // Adjust the postion of RectSelectionView
            triggeredView.frame = CGRect(x: pointerCurrentPositionInMainView.x - pointerTapGroupBeganPositionInRectSelectionView!.x, y: pointerCurrentPositionInMainView.y - pointerTapGroupBeganPositionInRectSelectionView!.y, width: triggeredViewSize.width, height: triggeredViewSize.height)
            
            // Get destnation position
            let destRectSelectionViewRect = triggeredView.frame
            
            // Get offset(moved)
            let offsetX = destRectSelectionViewRect.minX - orgRectSelectionViewRect.minX
            let offsetY = destRectSelectionViewRect.minY - orgRectSelectionViewRect.minY
            
            // Set selectedWordItems' frames
            rectSelectionView!.adjustSelectedWordItem(offsetX: offsetX, offsetY: offsetY)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            
            break;
            
        case .ended:
            
            // RectSelectionView
            rectSelectionView!.cancelAction()
            rectSelectionView!.removeFromSuperview()
            
            print("tapGroupEnd")
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            hideOrderNumberForWordItems()
            
            isTappingNow = false
            
            break;
            
        default:
            break;
        }
        
    }
    
    // Tap on mainView
    @objc private func mainViewTapGestureRecongnizerHandler(recongnizer:UITapGestureRecognizer){
        
        switch recongnizer.state {
            
        case .began:
            
            break;
            
        case .changed:

            break;
            
        case .ended:
            
            // Cancel selection
            rectSelectionView!.cancelAction()
            rectSelectionView!.removeFromSuperview()
            
            break;
            
        default:
            break;
        }
        
    }
    
    
    private func getResoultion()->String{
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        return "\(width)x\(height)"
    }
    
    private func submitQuestionAnswer(){
        
        let stringArray = QuestionHandler.getStringArrayFromWordItems(wordItems: wordItems)
        let content = QuestionHandler.convertStringArrayToDivision(stringArray: stringArray)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ActiveUserInfo.getToken(),
            ]
        
        let params = SubmitQuestionAnswerPostViewModel(questionDetail: assignmentQuestionVM!,resolution:getResoultion(),movementCollection: movementCollection,deviceAccelerationCollection:deviceAccelerationCollection, answerDivision: content, startDate: currentQuestionStartDate!, endDate: currentQuestionEndDate!)
        
        showActivityIndicatorOverlay()
        
//        for i in 0...movementCollection.count - 1{
//            print("index:\(movementCollection[i].index),targetElement:\(movementCollection[i].targetElement),state:\(movementCollection[i].state ),time:\(movementCollection[i].time)")
//        }
        
        AlamofireManager.sharedSessionManager.request(RemoteServiceManager.domain + "/MobileApplication/SubmitQuestionAnswer", method: .post, parameters: params.toDictionary(), encoding: JSONEncoding.default, headers:headers).responseJSON(completionHandler:
            {
                response in
                
                self.hideActivityIndicatorOverlay()
                
                switch(response.result){
                    
                case .success(_):
                    
                    if(response.response?.statusCode == 200){
                        
                        self.loadQuestion()
                    }
                    else if(response.response?.statusCode == 204){
                        
                        self.performSegue(withIdentifier: "GenerateAssignmentResult", sender: self.exerciseID)
                    }
                    
                    break
                    
                case .failure(let json):
                    
                    let dict = json as! [String:Any]
                    print(dict["message"] as! String)
                    
                    break
                }
        })
        
    }
    
    private func alertActionHandler(alertAction:UIAlertAction){
        
        switch alertAction.style {
        case .default:
            
            stopSmapling()
            submitQuestionAnswer()

            break
            
        case .cancel:
            print("cancel")
            break
            
        case .destructive:
            print("desturctive")
            break
            
        default:
            break
        }
    }

    
    @IBAction func moveToNextQuestion(_ sender: Any) {
        
        //
        self.present(alertDialog!, animated: true, completion: nil)
    }
    
    private func showActivityIndicatorOverlay(){
        view.addSubview(activityIndicatorOverlayView!)
        view.bringSubview(toFront: activityIndicatorOverlayView!)
    }
    private func hideActivityIndicatorOverlay(){
        activityIndicatorOverlayView?.removeFromSuperview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "GenerateAssignmentResult"){
            
            let dest = segue.destination as! AssignmentResultViewController
            // Sender is ExerciseID
            dest.exerciseID = sender as! Int
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

