//
//  SubmitQuestionAnswerPostViewModel.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class SubmitQuestionAnswerPostViewModel{
    
    var assignmentRecordID:Int = 0
    
    var sentenceEN:String = ""
    var sentenceJP:String = ""
    var division:String = ""
    var answerDivision:String = ""
    
    var resolution:String = ""
    
    var answer:String = ""
    
    var startDate:String = ""
    var endDate:String = ""
    
    var movementDTOs:[[String:Any]] = [[String:Any]]()
    var deviceAccelerationDTOs:[[String:Any]]  = [[String:Any]] ()
    
    init(questionDetail:AssignmentQuestionViewModel,resolution:String,movementDTOs:[MovementDTO],deviceAccelerationDTOs:[DeviceAccelerationDTO] ,answer:String,startDate:Date,endDate:Date) {
        self.assignmentRecordID = questionDetail.assignmentRecordID
        
        self.sentenceEN = questionDetail.sentenceEN
        self.sentenceJP = questionDetail.sentenceJP
        self.division = questionDetail.division
        self.answerDivision = questionDetail.answerDivision
        
        self.resolution = resolution
        
        self.answer = answer
        
        self.startDate = DateConverter.convertToStandardDateString(date: startDate)
        self.endDate = DateConverter.convertToStandardDateString(date: endDate)
        
        self.movementDTOs = DictionaryHandler.convertToDictonaryArray(objectArray: movementDTOs)
        self.deviceAccelerationDTOs = DictionaryHandler.convertToDictonaryArray(objectArray: deviceAccelerationDTOs)
    }
    
    public func toDictionary() -> [String:Any]{
        
        let dict:[String:Any] = [
            
            "assignmentRecordID":assignmentRecordID,
            
            "sentenceEN":sentenceEN,
            "sentenceJP":sentenceJP,
            "division":division,
            "answerDivision":answerDivision,
            "resolution":resolution,
            
            "answer":answer,
            "startDate":startDate,
            "endDate":endDate,
            
            "movementDTOs":movementDTOs,
            "deviceAccelerationDTOs":deviceAccelerationDTOs,
        ]
        
        return dict
    }
}
