//
//  ResultViewModel.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/2/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

public class ResultViewModel{
    
    private var _accuracyRate:Float = 0.0
    private var _resultAnswerDetails:[ResultAnswerDetail] = [ResultAnswerDetail]()
    
    public var accuracyRate:Float{
        get{
            return _accuracyRate
        }
        set(value){
            _accuracyRate = value
        }
    }
    
    public var resultAnswerDetails:[ResultAnswerDetail]{
        get{
            return _resultAnswerDetails
        }
        set(value){
            _resultAnswerDetails = value
        }
    }
}
