//
//  ExerciseSelectorViewModel.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/6/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class ExerciseDetail:ObjectFromDictionary{
    
    public var id:Int = 0
    public var name:String = ""
    public var description:String = ""
    public var currentNumber:Int = 1
    public var totalNumber:Int = 20
    public var isFinished:Bool = false
    
    init(id:Int,name:String,description:String,currentNumber:Int,totalNumber:Int,isFinished:Bool) {
        
        self.id = id
        self.name = name
        self.description = description
        self.currentNumber = currentNumber
        self.totalNumber = totalNumber
        self.isFinished = isFinished
        
    }
    
    required init(dict:[String:Any]){
        
        self.id = dict["id"] as! Int
        self.name = dict["name"] as! String
        self.description = dict["description"] as! String
        self.currentNumber = dict["currentNumber"] as! Int
        self.totalNumber = dict["totalNumber"] as! Int
        self.isFinished = dict["isFinished"] as! Bool
        
    }
    
}

class ExerciseListViewModel{
    
    public var exerciseDetails:[ExerciseDetail] = [ExerciseDetail]()
    
    init(exerciseDetails:[ExerciseDetail]) {
        self.exerciseDetails = exerciseDetails
    }
    
    init() {
    }
}
