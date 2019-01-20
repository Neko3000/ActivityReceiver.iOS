//
//  Movement.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class Movement:ObjectToDictionary{
    
    public var index:Int = 0
    public var state:Int = 0
    public var targetElement:String = ""
    public var time:Int = 0
    
    public var xPosition:Int = 0
    public var yPosition:Int = 0
    
    init(index:Int,state:Int,targetElement:String,time:Int,xPosition:Int,yPosition:Int) {
        
        self.index = index
        self.state = state
        self.targetElement = targetElement
        
        self.time = time
        
        self.xPosition = xPosition
        self.yPosition = yPosition
    }
    
    public func toDictionary() -> [String:Any] {
        
        let dict:[String:Any] = [
            
            "index":index,
            "state":state,
            "targetElement":targetElement,
            "time":time,
            "xPosition":xPosition,
            "yPosition":yPosition
        ]
        
        return dict
    }
}
