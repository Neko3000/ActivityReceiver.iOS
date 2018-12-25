//
//  AlamofireManager.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/19/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager{
    static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        return Alamofire.SessionManager(configuration: configuration)
    }()
}
