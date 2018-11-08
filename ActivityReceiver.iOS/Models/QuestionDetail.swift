//
//  Question.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/8/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class QuestionDetail{
    public var id:Int = 0
    public var sentenceJP:String = ""
    public var division:String = ""
    
    init(id:Int,sentenceJP:String,division:String) {
        
        self.id = id
        self.sentenceJP = sentenceJP
        self.division = division
    }
    
    init() {
        
    }
}
