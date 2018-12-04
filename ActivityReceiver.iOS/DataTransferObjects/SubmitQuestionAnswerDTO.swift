//
//  Movement.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class MovementDTO{
    
    public var index:Int = 0
    public var state:Int = 0
    public var targetElement:Int = 0
    public var time:Int = 0
    
    public var xPosition:Int = 0
    public var yPosition:Int = 0
    
    init(index:Int,state:Int,targetElement:Int,time:Int,xPosition:Int,yPosition:Int) {
        
        self.index = index
        self.state = state
        self.targetElement = targetElement
        
        self.time = time
        
        self.xPosition = xPosition
        self.yPosition = yPosition
    }
    
    public func convertToNSDictionary() -> NSDictionary {
        
        let movementDTODict:NSDictionary = [
            
            "index":index,
            "state":state,
            "targetElement":targetElement,
            "time":time,
            "xPosition":xPosition,
            "yPosition":yPosition
        ]
        
        return movementDTODict
    }
}

class SubmitQuestionAnswerDTO{
    
    public var questionID:Int = 0
    public var assignmentRecordID:Int = 0
    
    public var answer:String = ""
    public var startDate:Date = Date()
    public var endDate:Date = Date()
    
    public var movementDTOs:[MovementDTO] = [MovementDTO]()
    
    init(questionID:Int,assignmentRecordID:Int,answer:String,startDate:Date,endDate:Date,movementDTOs:[MovementDTO]) {
        self.questionID = questionID
        self.assignmentRecordID = assignmentRecordID
        
        self.answer = answer
        self.startDate = startDate
        self.endDate = endDate
        
        self.movementDTOs = movementDTOs
    }
    
}
