//
//  QuestionHandler.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/9/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class QuestionHandler{
    
    public static func convertStringArrayToDivision(stringArray:[String]) -> String{
        
        var division:String = ""
        for i in 0...stringArray.count - 1{
            if(i == 0){
                division = division + stringArray[i]
            }
            else{
                division = division + "|" + stringArray[i]
            }
        }
        
        return division
    }
    
    public static func getStringArrayFromWordItems(wordItems:[WordItem]) -> [String]{
        
        var stringArray:[String] = [String]()
        let sortedWordItems = wordItems.sorted(by: { $0.frame.minX < $1.frame.minX })
        
        for i in 0...sortedWordItems.count - 1{
            stringArray.append(sortedWordItems[i].textLabel.text ?? "")
        }
        
        return stringArray
    }
}
