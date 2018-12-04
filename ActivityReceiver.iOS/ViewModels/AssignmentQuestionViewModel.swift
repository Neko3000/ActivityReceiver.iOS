//
//  Question.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/8/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class AssignmentQuestionViewModel:ObjectFromDictionary{
    public var assignmentRecordID:Int = 0
    public var questionID:Int = 0
    
    public var sentenceEN:String = ""
    public var sentenceJP:String = ""
    public var division:String = ""
    public var answerDivision:String = ""
    
    public var currentNumber:Int = 0
    
    init(assignmentRecordID:Int,questionID:Int,sentenceEN:String,sentenceJP:String,division:String,answerDivision:String,currentNumber:Int) {
        
        self.assignmentRecordID = assignmentRecordID
        self.questionID = questionID
        
        self.sentenceEN = sentenceEN
        self.sentenceJP = sentenceJP
        self.division = division
        self.answerDivision = answerDivision
        
        self.currentNumber = currentNumber
    }
    
    init() {
        
    }
    
    required init(dict:[String:Any]) {
        
        self.assignmentRecordID = dict["assignmentRecordID"] as! Int
        self.questionID = dict["questionID"] as! Int
        
        self.sentenceEN = dict["sentenceEN"] as! String
        self.sentenceJP = dict["sentenceJP"] as! String
        self.division = dict["division"] as! String
        self.answerDivision = dict["answerDivision"] as! String
        
        self.currentNumber = dict["currentNumber"] as! Int
    }
}
