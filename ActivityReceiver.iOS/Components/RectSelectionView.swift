//
//  RectSelectionView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 1/19/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class RectSelectionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // Computed properties
    public var isEmptySelection:Bool{
        return selectedWordItemCollection.isEmpty
    }
    
    // Normal Properties
    private var selectedWordItemCollection = [WordItem]()
    
    // For touch
    private var superViewController:InteractiveTouchVC?
    private var beginTouchPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    private var isInitialized:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            // Styles
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 1
             
            isInitialized = true
        }
        
    }
    
    // Set delegate
    public func setSuperViewController(superVC:InteractiveTouchVC){
        superViewController = superVC
    }
    
    // 3D touch - get force value
    private func getForce(touch:UITouch)->Float{
        var force:Float = 0
        
        if #available(iOS 9.0, *) {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                // 3D Touch capable
                force = Float(touch.force/touch.maximumPossibleForce)
            }
        }
        
        return force.rounded(toPlaces: 5)
    }
    
    // Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Record the current position in the tapped WordItem
            beginTouchPoint = touch.location(in: self)
            
            // Auto
            superViewController!.generateAnswer()
            
            // UI
            superViewController!.generateOrderNumber()
            superViewController!.showOrderNumberForWordItems()
            
            // Store
            superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.dragGroupBegin,targetElement:generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            // State
            superViewController!.setTapState(isTappingNow: true)
            
            print("touch begain in rectSelectionView")
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Set the position of WordItem by offset
            let currentTouchPoint = touch.location(in: self)
            
            let offsetX = currentTouchPoint.x - beginTouchPoint.x
            let offsetY = currentTouchPoint.y - beginTouchPoint.y
            
            self.frame = self.frame.offsetBy(dx: offsetX, dy: offsetY)
            
            // Set selectedWordItems' frames
            adjustSelectedWordItem(offsetX: offsetX, offsetY: offsetY)
            
            // Auto
            superViewController!.generateAnswer()
            
            // UI
            superViewController!.generateOrderNumber()
            
            // Store
            superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.dragGroupMove,targetElement:generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            print("touch move in rectSelectionView")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Set the position of WordItem by offset
            let currentTouchPoint = touch.location(in: self)
            
            let offsetX = currentTouchPoint.x - beginTouchPoint.x
            let offsetY = currentTouchPoint.y - beginTouchPoint.y
            
            self.frame = self.frame.offsetBy(dx: offsetX, dy: offsetY)
            
            // Set selectedWordItems' frames
            adjustSelectedWordItem(offsetX: offsetX, offsetY: offsetY)
            
            // Cancel selection
            superViewController!.cancelSelection()
            
            // Auto
            superViewController!.generateAnswer()
            
            // UI
            superViewController!.generateOrderNumber()
            superViewController!.hideOrderNumberForWordItems()
            
            // Store
            superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.dragSingleEnd,targetElement:generateSelectedTargetElementIndexString(),force: getForce(touch: touch))
            
            // State
            superViewController!.setTapState(isTappingNow: false)
            
            print("touch end in rectSelectionView")
        }
        
    }
    
    // Show/hide self
    public func show(){
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    public func hide(){
        // Styles
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1
    }
    
    // Make selection
    public func selectWordItem(wordItemCollection:[WordItem]){
        
        selectedWordItemCollection.removeAll()
        
        for i in 0..<wordItemCollection.count{
            
            wordItemCollection[i].cancelActive()
            
            if(self.frame.intersects(wordItemCollection[i].frame)){
                selectedWordItemCollection.append(wordItemCollection[i])
                wordItemCollection[i].toActive()
            }
        }
    }
    
    // Adjust selected wordItems' frames
    public func adjustSelectedWordItem(offsetX:CGFloat,offsetY:CGFloat){
        
        for i in 0..<selectedWordItemCollection.count{

            let orgFrame = selectedWordItemCollection[i].frame
            selectedWordItemCollection[i].frame = CGRect(x: orgFrame.minX + offsetX, y: orgFrame.minY + offsetY, width: orgFrame.width, height: orgFrame.height)
        }
    }
    
    // Cancel selection this time
    public func cancelAction(){
        
        for i in 0..<selectedWordItemCollection.count{
            
            selectedWordItemCollection[i].cancelActive()
        }
        
        selectedWordItemCollection.removeAll()
    }
    
    // Generate selection string
    public func generateSelectedTargetElementIndexString() -> String{
        
        var selectionString = ""
        for i in 0..<selectedWordItemCollection.count{
            
            if(i == 0){
                selectionString = selectionString + "\(selectedWordItemCollection[i].index)"
            }
            else{
                selectionString = selectionString + "#" + "\(selectedWordItemCollection[i].index)"
            }
        }
        
        return selectionString
    }
    
    // Adjust self's frame
    public func setFrame(rect:CGRect){
        self.frame = rect
    }
}
