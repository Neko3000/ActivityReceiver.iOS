//
//  DateHandler.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/10/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class DateConverter{
    
    public static func convertToStandardDateString(date:Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date)
    }
}
