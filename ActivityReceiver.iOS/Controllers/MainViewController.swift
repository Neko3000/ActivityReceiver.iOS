//
//  ViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 9/26/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import UIView_draggable
import Alamofire

class MainViewController: UIViewController {

    // The list of all words in current question
    var words:[String]?
    
    // The list of all wordItems
    var wordItems = [WordItem]()
    
    // Movements
    // 20 time per second
    var samplingFrequency:Int = 10
    var movementCurrentIndex:Int = 0
    var movementDTOs = [MovementDTO]()
    
    // This factor records the original position value of pointer in the UIView(WordItem)
    // It will be used in panGesetureRecongnizerHandler function
    var pointerBeganPositionInWordItem:CGPoint?
    
    // Timer
    var timer:Timer?
    var lastRecordMillisecondTime:Int = 0
    var currentMillisecondTime:Int = 0
    
    // AlertController
    var alertDialog:UIAlertController?
    
    // Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //words = ["man","wise","oppotunities","finds","make","than","a","he","will"]
        
        // Load
        loadWordItems(index:0)
        
        alertDialog = UIAlertController(title: "確認", message: "今の解答でよろしいですか?", preferredStyle: .alert)
        alertDialog!.addAction(UIAlertAction(title: "はい", style:.default, handler: alertActionHandler(alertAction:)))
        alertDialog!.addAction(UIAlertAction(title: "いいえ", style:.cancel, handler: alertActionHandler(alertAction:)))
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime(){
        
        currentMillisecondTime += 1000/samplingFrequency
        
//        let d = Date()
//        let df = DateFormatter()
//        df.dateFormat = "y-MM-dd H:m:ss.SSSS"
//
//         // -> "2016-11-17 17:51:15.1720"
//        print(String(currentMillisecondTime) + "-" +
//            df.string(from: d))
        
    }
    
    private func loadWordItems(index:Int){

        // Request data from remote server
        Alamofire.request("http://118.25.44.137/question").responseJSON(completionHandler: {
            response in
            
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            
            
            if let json = response.result.value {
                //print("JSON: \(json)") // serialized json response
                
                // There are multiple questions
                let questions = json as! NSArray
                // Convert one question as Dictionary to get data by its key
                let currentQuestion = questions[index] as! NSDictionary
                
                // Set layout
                self.questionLabel.text = currentQuestion["sentenceJP"] as? String
                self.words = (currentQuestion["division"] as! String).components(separatedBy: "|")
                
                self.answerLabel.text = "-"
                
                self.generateWordItems()
                self.arrangeWordItems()
            }
            
            
        })
    }
    
    func printPosition(view:UIView){
        print("\(view.frame.minX) - \(view.frame.minY)")
    }
    
    private func generateWordItems(){
        
        // Clear
        clearCurrentQuestion()
        
        for index in 0...words!.count - 1{
            
            let topDistance:CGFloat = 20.0
            
            let singleWordItem = WordItem()
            
            singleWordItem.textLabel.text = words![index]
            singleWordItem.frame = CGRect(x: 0, y: 0, width: singleWordItem.textLabel.intrinsicContentSize.width + 40.0, height: singleWordItem.textLabel.intrinsicContentSize.height + 10.0 + topDistance)
            wordItems.append(singleWordItem)
            
            singleWordItem.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecongnizerHandler(recongnizer:))))
            singleWordItem.isUserInteractionEnabled = true
            
            //mainView.addSubview(singleWordItem)
            
            //answerLabel.text = "\(singleWordItem.textLabel.intrinsicContentSize.width) x \(singleWordItem.textLabel.intrinsicContentSize.height)"
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
        
        //arrage
        
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
    
    private func createMovementDTO(position:CGPoint,movementState:MovementState){
        
        if(lastRecordMillisecondTime < currentMillisecondTime){
            let movementDTONew = MovementDTO(index: movementCurrentIndex, state: movementState.rawValue, time: currentMillisecondTime, xPosition: Int(position.x), yPostion: Int(position.y))
            movementCurrentIndex = movementCurrentIndex + 1
            
            movementDTOs.append(movementDTONew)
            
            lastRecordMillisecondTime = currentMillisecondTime
        }
    }
        
    // WordItem's dragging behavior
    @objc private func panGestureRecongnizerHandler(recongnizer:UIPanGestureRecognizer){
        
        switch recongnizer.state {
            
        // How it works -
        // Firstly when tap begins, record the current position of finger in the tapped WordItem(Not the mainView)
        // So we got the relative position between tapped WordItem and user's finger
        // Then when every movement occurs, see where the user's finger is, get its current postion in mainView
        // By current position of user's finger in mainView and the relative position we got above, we could calculate where the tapped WordItem should be and move it
            
        // Formula -
        // ThePositionOfWordItem(Where it should be now) = CurrentPositionOfFinger(In mainView) + ThePositionWhenFingerFirstTapOnTheWordItem(Positive or negative)
            
        case .began:
            
            // Record the current position in the tapped WordItem
            pointerBeganPositionInWordItem = recongnizer.location(in: recongnizer.view)
            
            // auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            showOrderNumberForWordItems()
            
            // Create a new MovementDTO and push it into the array
            
            createMovementDTO(position: recongnizer.location(in: recongnizer.view), movementState: MovementState.tapSingleBegin)
            
            break;
            
        case .changed:
            
            // Get CurrentWordItem
            let currentWordItem = recongnizer.view as! WordItem
            
            // Get finger's current postion in mainView
            let pointerCurrentPositionInMainView = recongnizer.location(in: mainView)
            let triggeredViewSize = currentWordItem.frame.size
            
            // Adjust the postion of WordItem
            currentWordItem.frame = CGRect(x: pointerCurrentPositionInMainView.x - pointerBeganPositionInWordItem!.x, y: pointerCurrentPositionInMainView.y - pointerBeganPositionInWordItem!.y, width: triggeredViewSize.width, height: triggeredViewSize.height)
            
            //
            generateOrderNumber()
            
            createMovementDTO(position: recongnizer.location(in: recongnizer.view), movementState: MovementState.tapSingleMove)
            
            break;
            
        case .ended:
            
            // Auto
            generateAnswer()
            
            // UI
            generateOrderNumber()
            hideOrderNumberForWordItems()
            
            createMovementDTO(position: recongnizer.location(in: recongnizer.view), movementState: MovementState.tapSingleEnd)
            
            break;
        
        default:
            break;
        }
        
        print(movementDTOs.count)
    }
    
    var currentID = 1
    
    private func loadNext(index:Int){
        loadWordItems(index: index)
        
        currentID = currentID + 1
    }
    
    private func alertActionHandler(alertAction:UIAlertAction){
        
        switch alertAction.style {
        case .default:
            
            if(currentID > 1 )
            {
                performSegue(withIdentifier: "GenerateResult", sender: nil)
            }
            else{
                clearCurrentQuestion()
                loadNext(index: currentID)
            }
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

    
    @IBAction func nextQuestionBtn(_ sender: Any) {
        
        //
        self.present(alertDialog!, animated: true, completion: nil)
    }
    
    func loadViewFromNib() -> UIView {
        
        let nib = UINib(nibName: "WordItem", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

