//
//  ExerciseSelectorViewModel.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/6/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class ExerciseDetail{
    
    public var name:String = ""
    public var description:String = ""
    public var currentNumber:Int = 1
    public var totalNumber:Int = 20
    init(name:String,description:String,currentNumber:Int,totalNumber:Int) {
        
        self.name = name
        self.description = description
        self.currentNumber = currentNumber
        self.totalNumber = totalNumber
        
    }
    
}

class ExerciseSelectorViewModel{
    
    private var exerciseDetails:[ExerciseDetail] = [ExerciseDetail]()
    
    init(exerciseDetails:[ExerciseDetail]) {
        self.exerciseDetails = exerciseDetails
    }
    
    init() {
    }
}
