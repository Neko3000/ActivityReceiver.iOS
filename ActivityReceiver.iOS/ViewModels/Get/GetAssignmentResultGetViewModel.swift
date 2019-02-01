//
//  ResultViewModel.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/2/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

public class AssignmentResultAnswerDetail:ObjectFromDictionary
{
    public var sentenceJP:String = ""
    public var sentenceEN:String = ""
    public var answer:String = ""
    public var isCorrect:Bool = false
    
    init() {
        
    }
    
    init(sentenceJP:String,sentenceEN:String,answer:String,isCorrect:Bool) {
        self.sentenceJP = sentenceJP
        self.sentenceEN = sentenceEN
        self.answer = answer
        self.isCorrect = isCorrect
    }
    
    required init(dict:[String:Any]) {
        self.sentenceJP = dict["sentenceJP"] as! String
        self.sentenceEN = dict["sentenceEN"] as! String
        self.answer = dict["answerSentence"] as! String
        self.isCorrect = dict["isCorrect"] as! Bool
    }
    
    public func toDictionary() -> [String:Any] {
        let dict:[String:Any] = [
            "sentenceJP":sentenceJP,
            "sentenceEN":sentenceEN,
            "answer":answer,
            "isCorrect":isCorrect,
        ]
        
        return dict
    }
}

public class GetAssignmentResultGetViewModel{
    
    public var accuracyRate:Float = 0.0
    public var assignmentResultAnswerDetails:[AssignmentResultAnswerDetail] = [AssignmentResultAnswerDetail]()
    
    init() {
        
    }
    
    init(accuracyRate:Float,assignmentResultAnswerDetails:[AssignmentResultAnswerDetail]) {
        
        self.accuracyRate = accuracyRate
        self.assignmentResultAnswerDetails = assignmentResultAnswerDetails
    }
    
}
