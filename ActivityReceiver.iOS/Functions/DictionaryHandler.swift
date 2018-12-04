//
//  DictionaryHandler.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class DictionaryHandler{
    
    public static func convertToDictonaryArray<T:ObjectToDictionary>(objectArray:[T]) -> [[String:Any]]{
        
        var dictionaryArray = [[String:Any]]()
        for i in 0...objectArray.count - 1{
            
            let object = objectArray[i]
            dictionaryArray.append(object.toDictionary())
        }
        
        return dictionaryArray
    }
    
    public static func convertFromDictionaryArray<T:ObjectFromDictionary> (dictionaryArray:NSArray) -> [T]{
        
        var objectArray:[T] = [T]()
        for i in 0...dictionaryArray.count - 1{
            
            let object = T.init(dict:dictionaryArray[i] as! [String:Any])
            objectArray.append(object)
        }
        
        return objectArray
    }
}
