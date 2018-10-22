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

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    // the list of all words in current question
    var words:[String]?
    
    // the list of all wordItems
    var wordItems = [WordItem]()
    
    // this factor records the original position value of pointer in the UIView(WordItem)
    // it will be used in panGesetureRecongnizerHandler function
    var pointerBeganPositionInWordItem:CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        words = ["man","wise","oppotunities","finds","make","than","a","he","will"]
        
        loadWordItems(index:0)
    }
    
    func loadWordItems(index:Int){
        //view.addSubview(wordItem)
        Alamofire.request("http://118.25.44.137/question").responseJSON(completionHandler: {
            response in
            
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            
            
            if let json = response.result.value {
                //print("JSON: \(json)") // serialized json response
                
                let questions = json as! NSArray
                let currentQuestion = questions[index] as! NSDictionary
                
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
    
    var closure:(UIView?) -> () = { (view:UIView?) in
        
        print("i won")
        
    }
    
    func generateWordItems(){
        
        // clear
        for remainedWordItem in wordItems{
            remainedWordItem.removeFromSuperview()
        }
        
        wordItems.removeAll()
        
        for index in 0...words!.count - 1{
            
            let singleWordItem = WordItem()
            
            singleWordItem.textLabel.text = words![index]
            singleWordItem.frame = CGRect(x: 0, y: 0, width: singleWordItem.textLabel.intrinsicContentSize.width + 40, height: singleWordItem.textLabel.intrinsicContentSize.height + 10)
            wordItems.append(singleWordItem)
            
            singleWordItem.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecongnizerHandler(recongnizer:))))
            singleWordItem.isUserInteractionEnabled = true
            
            //mainView.addSubview(singleWordItem)
            
            //answerLabel.text = "\(singleWordItem.textLabel.intrinsicContentSize.width) x \(singleWordItem.textLabel.intrinsicContentSize.height)"
        }
    }

    func arrangeWordItems(){
        
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
    
    func generateAnswer(){
        
        var answer:String = ""
        let sortedWordItems = wordItems.sorted(by: { $0.frame.minX < $1.frame.minX })
        
        for index in 0...sortedWordItems.count - 1{
            
            if(index == 0){
                answer += sortedWordItems[index].textLabel.text!
            }
            else{
                answer += " " + sortedWordItems[index].textLabel.text!
            }
        }
        
        answer += "."
        answer.capitalizeFirstLetter()
        
        answerLabel.text = answer
    }
    
    @objc private func panGestureRecongnizerHandler(recongnizer:UIPanGestureRecognizer){
        switch recongnizer.state {
            
        case .began:
            pointerBeganPositionInWordItem = recongnizer.location(in: recongnizer.view)
            break;
            
        case .changed:
            let pointerCurrentPositionInMainView = recongnizer.location(in: mainView)
            let triggeredViewSize = recongnizer.view!.frame.size
            recongnizer.view!.frame = CGRect(x: pointerCurrentPositionInMainView.x - pointerBeganPositionInWordItem!.x, y: pointerCurrentPositionInMainView.y - pointerBeganPositionInWordItem!.y, width: triggeredViewSize.width, height: triggeredViewSize.height)
            break;
            
        case .ended:
            generateAnswer()
            break;
        
        default:
            break;
        }
        
    }
    
    @IBAction func nextQuestionBtn(_ sender: Any) {
        loadWordItems(index: 1)
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

