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

class DoAssignmentViewController: UIViewController,InteractiveTouchVC{

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
    
    // Sample 20 times per second
    var samplingFrequency:Int = 20
    
    // Store
    var movementCollection = [Movement]()
    var deviceAccelerationCollection = [DeviceAcceleration]()
    
    // Touch
    var beginTouchPoint:CGPoint?
    
    // GroupSelectionView
    var rectSelectionView:RectSelectionView?
    
    // Date
    var currentQuestionStartDate:Date?
    var currentQuestionEndDate:Date?
    
    // Timer
    var timer:Timer?
    var currentMillisecondTime:Int = 0
    
    // AlertController
    var alertDialog:UIAlertController?
    
    // NVActivityIndicatorView
    var activityIndicatorOverlayView:ActivityIndicatorOverlayView?
    
    // Operation state
    var isTappingNow:Bool = false
    var isGroupingNow:Bool = false
    
    // Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var confusionDegreeSurveyView: ConfusionDegreeSurveyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Basic layout
        confusionDegreeSurveyView.layer.zPosition = 1
        confusionDegreeSurveyView.layer.applySketchShadow(color: UIColor(named: "Shadow-LightGrey")!, alpha: 0.8, x: 0, y: 10.0, blur: 30.0, spread: 0)
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
        rectSelectionView?.setSuperViewController(superVC: self)
        
        // ActivityIndicatorOverlayView
        activityIndicatorOverlayView = ActivityIndicatorOverlayView()
        activityIndicatorOverlayView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        // Timer controls sampling
        startSampling()
        
    }
    
    // 3D touch - get force value
    private func getForce(touch:UITouch)->Float{
        var force:Float = 0
        
        if #available(iOS 9.0, *) {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                force = Float(touch.force/touch.maximumPossibleForce)
            }
        }
        
        return force.rounded(toPlaces: 5)
    }
    
    /* Touch */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // If RectSelection exists, cancel it
            cancelSelection()
            storeMovement(position: touch.location(in: mainView), movementState: MovementState.cancelGroup,targetElement:rectSelectionView!.generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            // RectSelectionView
            mainView.addSubview(rectSelectionView!)
            rectSelectionView?.layer.zPosition = 1
            
            // Record the current position in the tapped WordItem
            beginTouchPoint = touch.location(in: mainView)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            showOrderNumberForWordItems()
            
            // Selection
            rectSelectionView!.selectWordItem(wordItemCollection: wordItems)
            
            // Store
            storeMovement(position: touch.location(in: mainView), movementState: MovementState.makeGroupBegin,targetElement:rectSelectionView!.generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            setTapState(isTappingNow: true)
            
            print("touch begain in mainView")
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Show rectSelectionView when move
            rectSelectionView!.show()
            
            // Get finger's current postion in mainView
            let currentTouchPoint = touch.location(in: mainView)
            
            // Set RectSelectionView's frame
            let rect = CGRect(x:min(beginTouchPoint!.x, currentTouchPoint.x),
                              y:min(beginTouchPoint!.y, currentTouchPoint.y),
                              width:fabs(beginTouchPoint!.x - currentTouchPoint.x),
                              height:fabs(beginTouchPoint!.y - currentTouchPoint.y));
            
            rectSelectionView!.setFrame(rect: rect)
            
            // Selection
            rectSelectionView!.selectWordItem(wordItemCollection: wordItems)
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            
            // Store
            storeMovement(position: touch.location(in: mainView), movementState: MovementState.makeGroupMove,targetElement:rectSelectionView!.generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            print("touch move in mainView")
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Selection
            rectSelectionView!.selectWordItem(wordItemCollection: wordItems)
            
            if(rectSelectionView!.isEmptySelection){
                
                cancelSelection()
            }
            
            rectSelectionView!.hide()
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            hideOrderNumberForWordItems()
            
            // Store
            storeMovement(position: touch.location(in: mainView), movementState: MovementState.makeGroupEnd,targetElement:rectSelectionView!.generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            setTapState(isTappingNow: false)
        
            print("touch end in mainView")
        }
    }
    
    /* Sample */
    private func startSampling(){
        
        // Acceleration
        if #available(iOS 4.0, *){
            if(motionManager.isAccelerometerAvailable){
                motionManager.accelerometerUpdateInterval = 1.0/Double(samplingFrequency)
                
                motionManager.startAccelerometerUpdates()
            }
        }
        
        // Timer
        timer = Timer.scheduledTimer(timeInterval: 1.0/Double(samplingFrequency), target: self, selector: #selector(samplingHandler), userInfo: nil, repeats: true)
        
        currentQuestionStartDate = Date()
        
        currentMillisecondTime = 0
    }
    
    private func stopSmapling(){
        
        // Acceleration
        if #available(iOS 4.0, *){
            if(motionManager.isAccelerometerAvailable){
                
                motionManager.stopAccelerometerUpdates()
            }
        }
        
        if(timer != nil){
            timer!.invalidate()
            timer = nil
        }
        
        currentQuestionEndDate = Date()
    }
    
    private func updateTime(){
        currentMillisecondTime += 1000/samplingFrequency
        
    }
    
    @objc private func samplingHandler(){
        
        if(isTappingNow){
            
            // StoreMovement is handled by touch functions
            storeDeviceAcceleration()
        }
        
        updateTime()
    }
    
    /* UI(initialization) */
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
        
        for index in 0..<words!.count{
            
            let topDistance:CGFloat = 20.0
            
            let singleWordItem = WordItem()
            
            singleWordItem.index = index
            singleWordItem.textLabel.text = words?[index]
            singleWordItem.frame = CGRect(x: 0, y: 0, width: singleWordItem.textLabel.intrinsicContentSize.width + 40.0, height: singleWordItem.textLabel.intrinsicContentSize.height + 10.0 + topDistance)

            singleWordItem.setSuperViewController(superVC: self)
            wordItems.append(singleWordItem)
            
            //singleWordItem.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecongnizerHandlerForWordItem(recongnizer:))))
            singleWordItem.isUserInteractionEnabled = true
            
        }
    }

    private func arrangeWordItems(){
        
        let bottomSpace:CGFloat = 100.0
        
        let horizontalPadding:CGFloat = 10.0
        let verticalPadding:CGFloat = 10.0
        
        let wordItemHeight = wordItems[0].frame.height
        
        let containerLength = mainView.frame.width
        let containerHeight = mainView.frame.height
        var lines = [[WordItem]]()
        var currentLine = [WordItem]()
        var currentLineLength:CGFloat = 0.0
        
        for index in 0..<wordItems.count{
            
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
        for lineNumber in 0..<lines.count{
            var currentXPosition:CGFloat = 0.0
            
            for wordItemNumber in 0...lines[lineNumber].count - 1{
                
                lines[lineNumber][wordItemNumber].frame = CGRect(x: currentXPosition + horizontalPadding, y: containerHeight - CGFloat(lines.count - lineNumber) * (wordItemHeight + verticalPadding) - bottomSpace, width: lines[lineNumber][wordItemNumber].frame.width, height: lines[lineNumber][wordItemNumber].frame.height)

                
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
        deviceAccelerationCollection.removeAll()
    }
    
    /* DeviceAcceleration */
    private func storeDeviceAcceleration(){
        
        if #available(iOS 4.0, *){
            if(motionManager.isAccelerometerAvailable){
                let accelerationX:Float = Float(motionManager.accelerometerData?.acceleration.x ?? 0)
                let accelerationY:Float = Float(motionManager.accelerometerData?.acceleration.y ?? 0)
                let accelerationZ:Float = Float(motionManager.accelerometerData?.acceleration.z ?? 0)
                
                deviceAccelerationCollection.append(DeviceAcceleration(index:deviceAccelerationCollection.count, time:currentMillisecondTime,x: accelerationX, y: accelerationY, z: accelerationZ))
            }
        }
    }
    
    /* Network */
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
    
    private func submitQuestionAnswer(){
        
        let stringArray = QuestionHandler.getStringArrayFromWordItems(wordItems: wordItems)
        let content = QuestionHandler.convertStringArrayToDivision(stringArray: stringArray)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ActiveUserInfo.getToken(),
            ]
        
        let params = SubmitQuestionAnswerPostViewModel(questionDetail: assignmentQuestionVM!,resolution:getResoultion(),movementCollection: movementCollection,deviceAccelerationCollection:deviceAccelerationCollection, answerDivision: content, startDate: currentQuestionStartDate!, endDate: currentQuestionEndDate!)
        
        showActivityIndicatorOverlay()
        
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
    
    /* UI(finish) */
    @IBAction func moveToNextQuestion(_ sender: Any) {
        
        //
        self.present(alertDialog!, animated: true, completion: nil)
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
    
    /* UI(upload) */
    private func showActivityIndicatorOverlay(){
        view.addSubview(activityIndicatorOverlayView!)
        view.bringSubview(toFront: activityIndicatorOverlayView!)
    }
    private func hideActivityIndicatorOverlay(){
        activityIndicatorOverlayView?.removeFromSuperview()
    }

    /* Resolution */
    private func getResoultion()->String{
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        return "\(width)x\(height)"
    }
    
    /* From Protocol */
    // Cancel selection
    func cancelSelection() {
        
        // If RectSelection exists, cancel it
        rectSelectionView!.cancelAction()
        rectSelectionView!.removeFromSuperview()
    }
    
    // Generate answer base on the positions of WordItems
    func generateAnswer(){
        
        var answer:String = ""
        
        // Sort WordItems by their x-postion
        let sortedWordItems = wordItems.sorted(by: { $0.frame.minX < $1.frame.minX })
        
        for index in 0..<sortedWordItems.count{
            
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
    
    // Show/Hide order numbers when user is tapping on WordItem
    func showOrderNumberForWordItems(){
        for index in 0..<wordItems.count{
            wordItems[index].showOrderNumber()
        }
    }
    func hideOrderNumberForWordItems(){
        for index in 0..<wordItems.count{
            wordItems[index].hideOrderNumber()
        }
    }
    
    // Generate correct order numbers based on the current arrangement
    func generateOrderNumber(){
        let sortedWordItems = wordItems.sorted(by: { $0.frame.minX < $1.frame.minX })
        
        for index in 0..<sortedWordItems.count{
            sortedWordItems[index].orderNumberLabel.text = String(index + 1)
        }
        
    }
    
    // Set state
    func setTapState(isTappingNow:Bool){
        self.isTappingNow = isTappingNow
    }
    func setGroupState(isGroupingNow:Bool){
        self.isGroupingNow = isGroupingNow
    }
    
    // Group
    func getGroupTargetElementString() -> String{
        return rectSelectionView!.generateSelectedTargetElementIndexString()
    }
    
    // Store Movement
    func storeMovement(position:CGPoint,movementState:MovementState,targetElement:String,force:Float){
        
        if(!movementCollection.isEmpty){
            
            if((movementState == .dragSingleMove || movementState == .dragGroupMove) && currentMillisecondTime < movementCollection.last!.time + 1000/samplingFrequency ){
                return
            }
        }
        
        let movement = Movement(index: movementCollection.count, state: movementState.rawValue, targetElement:targetElement, time: currentMillisecondTime, xPosition: Int(position.x), yPosition: Int(position.y),force:force)
        
        movementCollection.append(movement)
    }

    /* Segue */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "GenerateAssignmentResult"){
            
            let dest = segue.destination as! AssignmentResultViewController
            // Sender is ExerciseID
            dest.exerciseID = sender as! Int
        }
    }
    
    /* Others */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
