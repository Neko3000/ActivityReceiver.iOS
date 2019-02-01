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
    var rectSelectionView:RectSelectionView?{ get }
    
    // Selection
    func cancelSelectionAndRemove()
    
    // UI
    func generateAnswer()
    func generateOrderNumber()
    func showOrderNumberForWordItems()
    func hideOrderNumberForWordItems()
    
    // State
    func setTapState(isTappingNow:Bool)
    func setGroupState(isGroupingNow:Bool)
    
    func getTapState()->Bool
    func getGroupState()->Bool
    
    // StoreMovement
    func storeMovement(position:CGPoint,movementState:MovementState,targetElement:String,force:Float)
}
