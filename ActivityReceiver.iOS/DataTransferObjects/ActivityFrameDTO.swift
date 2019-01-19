//
//  ActivityFrame.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/5/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class ActivityFrameDTO:ObjectToDictionary{
    
    public var index:Int = 0
    public var time:Int = 0
    public var movement:Movement?
    public var deviceAcceleration:DeviceAcceleration?
    
    init(index:Int,time:Int,movement:Movement,deviceAcceleration:DeviceAcceleration) {
        
        self.index = index
        self.time = time
        self.movement = movement
        self.deviceAcceleration = deviceAcceleration
    }
    
    public func toDictionary() -> [String:Any] {
        
        let dict:[String:Any] = [
            
            "index":index,
            "time":time,
            "movement":movement?.toDictionary() ?? "",
            "deviceAcceleration":deviceAcceleration?.toDictionary() ?? "",
            ]
        
        return dict
    }
}

