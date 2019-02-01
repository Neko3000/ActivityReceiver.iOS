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
    var standardAnswerDivision:String = ""
    
    var resolution:String = ""
    
    var answerDivision:String = ""
    
    var startDate:String = ""
    var endDate:String = ""
    
    var movementCollection:[[String:Any]] = [[String:Any]]()
    var deviceAccelerationCollection:[[String:Any]]  = [[String:Any]] ()
    
    init(getNextQuestionGetVM:GetNextQuestionGetViewModel,resolution:String,movementCollection:[Movement],deviceAccelerationCollection:[DeviceAcceleration] ,answerDivision:String,startDate:Date,endDate:Date) {
        
        self.assignmentRecordID = getNextQuestionGetVM.assignmentRecordID
        
        self.sentenceEN = getNextQuestionGetVM.sentenceEN
        self.sentenceJP = getNextQuestionGetVM.sentenceJP
        self.division = getNextQuestionGetVM.division
        self.standardAnswerDivision = getNextQuestionGetVM.standardAnswerDivision
        
        self.resolution = resolution
        
        self.answerDivision = answerDivision
        
        self.startDate = DateConverter.convertToStandardDateString(date: startDate)
        self.endDate = DateConverter.convertToStandardDateString(date: endDate)
        
        self.movementCollection = DictionaryHandler.convertToDictonaryArray(objectArray: movementCollection)
        self.deviceAccelerationCollection = DictionaryHandler.convertToDictonaryArray(objectArray: deviceAccelerationCollection)
    }
    
    public func toDictionary() -> [String:Any]{
        
        let dict:[String:Any] = [
            
            "assignmentRecordID":assignmentRecordID,
            
            "sentenceEN":sentenceEN,
            "sentenceJP":sentenceJP,
            "division":division,
            "standardAnswerDivision":standardAnswerDivision,
            "resolution":resolution,
            
            "answerDivision":answerDivision,
            "startDate":startDate,
            "endDate":endDate,
            
            "movementCollection":movementCollection,
            "deviceAccelerationCollection":deviceAccelerationCollection,
        ]
        
        return dict
    }
}
