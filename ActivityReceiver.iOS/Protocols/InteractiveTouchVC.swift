//
//  InteractiveTouchVC.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 1/27/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import UIKit

protocol InteractiveTouchVC {
    
    // View
    var mainView:UIView!{ get }
    
    // Selection
    func cancelSelection()
    
    // UI
    func generateAnswer()
    func generateOrderNumber()
    func showOrderNumberForWordItems()
    func hideOrderNumberForWordItems()
    
    // State
    func setTapState(isTappingNow:Bool)
    func setGroupState(isGroupingNow:Bool)
    
    // StoreMovement
    func storeMovement(position:CGPoint,movementState:MovementState,targetElement:String,force:Float)
    
    // Group selection - for WordItem
    func getGroupTargetElementString() -> String
}
