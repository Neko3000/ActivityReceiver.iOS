//
//  FloatExtension.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 1/27/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

extension Float {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
