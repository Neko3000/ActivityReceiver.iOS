//
//  MovementState.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

enum MovementState:Int{
    
    // Cases for the behavoir tapping single WordItem
    case tapSingleBegin = 0
    case tapSingleMove = 1
    case tapSingleEnd = 2
    
    // Cases for the behavior making group for multiple WordItem
    case makeGroupBegin = 3
    case makeGroupMove = 4
    case makeGroupEnd = 5
    
    // Cases for the behavior tapping multiple WordItem when they are selected
    case tapGroupBegin = 6
    case tapGroupMove = 7
    case tapGroupEnd = 8
    
}
