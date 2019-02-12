//
//  MovementHandler.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 2/12/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class MovementHandler{
    
    //
    public static func IncreaseIndex(movementCollection: inout [Movement],startIndex:Int,increaseValue:Int){
        
        for i in startIndex..<movementCollection.count{
            movementCollection[i].index += increaseValue
        }
        
    }
    
    //
    public static func Fix(movementCollection: inout [Movement]){
        
        var index:Int = 0
        
        while(index < movementCollection.count){
            switch(movementCollection[index].state){
                
            case MovementState.dragSingleBegin.rawValue:
                
                index += 1
                
                while(movementCollection[index].state == MovementState.dragSingleMove.rawValue){
                    index += 1
                }
                
                if(movementCollection[index].state != MovementState.dragSingleEnd.rawValue){
                    
                    let lastMovement = movementCollection[index - 1]
                    let insertedMovement = Movement(index: index, state: MovementState.dragSingleEnd.rawValue, targetElement: lastMovement.targetElement, time: lastMovement.time, xPosition: lastMovement.xPosition, yPosition: lastMovement.yPosition, force: lastMovement.force)
                    
                    movementCollection.insert(insertedMovement, at: index)
                    MovementHandler.IncreaseIndex(movementCollection: &movementCollection, startIndex: index + 1, increaseValue: 1)
                }
                
                index += 1
                
                break
                
                
            case MovementState.makeGroupBegin.rawValue:
                
                index += 1
                
                while(movementCollection[index].state == MovementState.makeGroupMove.rawValue){
                    index += 1
                }
                
                if(movementCollection[index].state != MovementState.makeGroupEnd.rawValue){
                    
                    let lastMovement = movementCollection[index - 1]
                    let insertedMovement = Movement(index: index, state: MovementState.makeGroupEnd.rawValue, targetElement: lastMovement.targetElement, time: lastMovement.time, xPosition: lastMovement.xPosition, yPosition: lastMovement.yPosition, force: lastMovement.force)
                    
                    movementCollection.insert(insertedMovement, at: index)
                    MovementHandler.IncreaseIndex(movementCollection: &movementCollection, startIndex: index + 1, increaseValue: 1)
                    
                    
                }
                
                index += 1
                
                break
                
                
            case MovementState.dragGroupBegin.rawValue:
                
                index += 1
                
                while(movementCollection[index].state == MovementState.dragGroupMove.rawValue){
                    index += 1
                }
                
                if(movementCollection[index].state != MovementState.dragGroupEnd.rawValue){
                    
                    let lastMovement = movementCollection[index - 1]
                    let insertedMovement = Movement(index: index, state: MovementState.dragGroupEnd.rawValue, targetElement: lastMovement.targetElement, time: lastMovement.time, xPosition: lastMovement.xPosition, yPosition: lastMovement.yPosition, force: lastMovement.force)
                    
                    movementCollection.insert(insertedMovement, at: index)
                    MovementHandler.IncreaseIndex(movementCollection: &movementCollection, startIndex: index + 1, increaseValue: 1)
                    
                    
                }
                
                index += 1
                
                break
                
            case MovementState.cancelGroup.rawValue:
                
                index += 1
                
                break
                
                
            default:
                break
            }
        }
        
    }
}
