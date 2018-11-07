//
//  ResultViewModel.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/2/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

public class ResultAnswerDetail
{
    public var sentenceJP:String = ""
    public var sentenceEN:String = ""
    public var answer:String = ""
    public var isCorrect:Bool = false
    
    
    init(sentenceJP:String,sentenceEN:String,answer:String,isCorrect:Bool) {
        self.sentenceJP = sentenceJP
        self.sentenceEN = sentenceEN
        self.answer = answer
        self.isCorrect = isCorrect
    }
}

public class ResultViewModel{
    
    public var accuracyRate:Float = 0.0
    public var resultAnswerDetails:[ResultAnswerDetail] = [ResultAnswerDetail]()
    
    init(accuracyRate:Float,resultAnswerDetails:[ResultAnswerDetail]) {
        
        self.resultAnswerDetails = resultAnswerDetails
    }
    
    init() {
        
    }
}
