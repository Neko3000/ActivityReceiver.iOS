//
//  DeviceAcceleration.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/5/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class DeviceAccelerationDTO:ObjectToDictionary{
    
    public var index:Int = 0
    
    public var time:Int = 0
    
    public var x:Float = 0
    public var y:Float = 0
    public var z:Float = 0
    
    init(){
        
    }
    
    init(index:Int,time:Int,x:Float,y:Float,z:Float) {
        
        self.index = index
        self.time = time
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func toDictionary() -> [String:Any] {
        
        let dict:[String:Any] = [
            "index":index,
            "time":time,
            "x":x,
            "y":y,
            "z":z,
        ]
        
        return dict
    }
}
