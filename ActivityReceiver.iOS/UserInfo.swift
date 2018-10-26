//
//  UserState.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/26/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class UserInfo: NSObject,NSCoding {
    
    var username:String
    var token:String
    
    func getUsername() -> String{
        return username
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "username")
        aCoder.encode(token, forKey: "token")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let token = aDecoder.decodeObject(forKey: "token") as! String
        
        self.init(username: username, token: token)
    }
    
    init(username:String,token:String) {
        self.username = username
        self.token = token
    }
}
