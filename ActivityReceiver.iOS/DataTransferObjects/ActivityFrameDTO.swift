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
    public var movementDTO:MovementDTO?
    public var deviceAccelerationDTO:DeviceAccelerationDTO?
    
    init(index:Int,time:Int,movementDTO:MovementDTO,deviceAccelerationDTO:DeviceAccelerationDTO) {
        
        self.index = index
        self.time = time
        self.movementDTO = movementDTO
        self.deviceAccelerationDTO = deviceAccelerationDTO
    }
    
    public func toDictionary() -> [String:Any] {
        
        let dict:[String:Any] = [
            
            "index":index,
            "time":time,
            "movementDTO":movementDTO?.toDictionary() ?? "",
            "deviceAccelerationDTO":deviceAccelerationDTO?.toDictionary() ?? "",
            ]
        
        return dict
    }
}

