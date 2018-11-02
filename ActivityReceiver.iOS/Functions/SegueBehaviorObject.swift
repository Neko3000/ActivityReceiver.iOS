//
//  SegueBehaviorObject.swift
//  StarryTarget
//
//  Created by Xueliang Chen on 2/8/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

protocol SegueBehaviorObject:NSObjectProtocol{
    
    func segueToAnotherScreen(withIdentifier identifier:String,sender:Any?)->Void;
    
}
