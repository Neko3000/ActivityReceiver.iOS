//
//  MovementState.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

enum MovementState:Int{
    
    // Cases here are for single WordItem tapped behaviors
    case tapSingleBegin = 0
    case tapSingleMove = 1
    case tapSingleEnd = 2
    
    // Cases here are for grouping WordItem tapped behaviors
    case tapGroupBegin = 3
    case tapGroupMove = 4
    case tapGroupEnd = 5
}
