//
//  ViewControllerExtension.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 2/23/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    // 3D touch - get force value
    func getForce(touch:UITouch)->Float{
        var force:Float = 0
        
        if #available(iOS 9.0, *) {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                force = Float(touch.force/touch.maximumPossibleForce)
            }
        }
        
        return force.rounded(toPlaces: 5)
    }
    
}
