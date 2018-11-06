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
    public var time:Int = 0
    
    public var xPosition:Int = 0
    public var yPostion:Int = 0
    
    init(index:Int,state:Int,time:Int,xPosition:Int,yPostion:Int) {
        
        self.index = index
        self.state = state
        self.time = time
        
        self.xPosition = xPosition
        self.yPostion = yPostion
    }
}
