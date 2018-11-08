//
//  FunctionExecuteTarget.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/8/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

protocol FunctionExecuteTarget:NSObjectProtocol {
    
    func executedFunction(sender:Any?)->Void
}
