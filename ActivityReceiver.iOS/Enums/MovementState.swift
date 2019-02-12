//
//  MovementState.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

enum MovementState:Int{
    
    // Cases for the behavior dragging single WordItem
    case dragSingleBegin = 0
    case dragSingleMove = 1
    case dragSingleEnd = 2
    
    // Cases for the behavior making group for multiple WordItem
    case makeGroupBegin = 3
    case makeGroupMove = 4
    case makeGroupEnd = 5
    
    // Cases for the behavior dragging multiple WordItem when they are selected
    case dragGroupBegin = 6
    case dragGroupMove = 7
    case dragGroupEnd = 8
    
    // Cancel group
    case cancelGroup = 9
    
}
