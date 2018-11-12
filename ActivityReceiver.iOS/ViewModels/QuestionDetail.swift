//
//  Question.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/8/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class QuestionDetail{
    public var assignmentRecordID:Int = 0
    public var questionID:Int = 0
    
    public var sentenceJP:String = ""
    public var division:String = ""
    
    public var currentNumber:Int = 0
    
    init(assignmentRecordID:Int,questionID:Int,sentenceJP:String,division:String,currentNumber:Int) {
        
        self.assignmentRecordID = assignmentRecordID
        self.questionID = questionID
        self.sentenceJP = sentenceJP
        self.division = division
        self.currentNumber = currentNumber
    }
    
    init() {
        
    }
    
    init(dict:NSDictionary) {
        
        self.assignmentRecordID = dict["assignmentRecordID"] as! Int
        self.questionID = dict["questionID"] as! Int
        self.sentenceJP = dict["sentenceJP"] as! String
        self.division = dict["division"] as! String
        self.currentNumber = dict["currentNumber"] as! Int
    }
}
