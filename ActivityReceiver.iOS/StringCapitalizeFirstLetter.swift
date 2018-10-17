//
//  StringCapitalizeFirstLetter.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/16/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
