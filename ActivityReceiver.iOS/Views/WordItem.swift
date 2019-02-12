//
//  WordItem.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/9/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class WordItem: XibUIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public var index:Int = 0
    
    // For touch
    private var superViewController:InteractiveTouchVC?
    private var beginTouchPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    // Outlets
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet var mainContainerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    private var isInitialized:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            // Styles
            backgroundView.layer.cornerRadius = 5.0
            backgroundView.clipsToBounds = true
            
            // The default value of alpha of numbers is 0
            hideOrderNumber()
            
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
            
            if(superViewController!.getGroupState()){
                // If RectSelection exists, cancel it
                superViewController!.cancelSelectionAndRemove()
                
                superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.cancelGroup,targetElement:"",force: 0)
            }

            // Record the current position in the tapped WordItem
            beginTouchPoint = touch.location(in: self)
            
            // Auto
            superViewController!.generateAnswer()
            
            // UI
            superViewController!.generateOrderNumber()
            superViewController!.showOrderNumberForWordItems()
            
            // Store
            superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.dragSingleBegin,targetElement:String(self.index),force: 0)
            
            // State
            superViewController!.setTapState(isTappingNow: true)
            
            //print("touch begain in wordItem - " + self.textLabel.text! + ",force:\(getForce(touch: touch))")
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Set the position of WordItem by offset
            let currentTouchPoint = touch.location(in: self)
            
            let offsetX = currentTouchPoint.x - beginTouchPoint.x
            let offsetY = currentTouchPoint.y - beginTouchPoint.y
            
            self.frame = self.frame.offsetBy(dx: offsetX, dy: offsetY)
            
            // Auto
            superViewController!.generateAnswer()
            
            // UI
            superViewController!.generateOrderNumber()
            
            // Store
            superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.dragSingleMove,targetElement:String(self.index),force: getForce(touch: touch))
            
            //print("touch move in wordItem - " + self.textLabel.text! + ",force:\(getForce(touch: touch))")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            // Set the position of WordItem by offset
            let currentTouchPoint = touch.location(in: self)
            
            let offsetX = currentTouchPoint.x - beginTouchPoint.x
            let offsetY = currentTouchPoint.y - beginTouchPoint.y
            
            self.frame = self.frame.offsetBy(dx: offsetX, dy: offsetY)
            
            // Auto
            superViewController!.generateAnswer()
            
            // UI
            superViewController!.generateOrderNumber()
            superViewController!.hideOrderNumberForWordItems()
            
            // Store
            superViewController!.storeMovement(position: touch.location(in: superViewController!.mainView), movementState: MovementState.dragSingleEnd,targetElement:String(self.index),force: 0)
            
            // State
            superViewController!.setTapState(isTappingNow: false)
            
            //print("touch end in wordItem - " + self.textLabel.text! + ",force:\(getForce(touch: touch))")
        }
        
    }

    // These two functions are used to set the alpha value of numbers, where are on the top of each WordItem
    public func showOrderNumber(){
        orderNumberLabel.alpha = 1.0
        
    }
    
    public func hideOrderNumber(){
        orderNumberLabel.alpha = 0
        
    }
    
    // For group selection
    public func toActive(){
        backgroundView.backgroundColor = UIColor(named: "NormalAquamarine")!
    }
    
    public func cancelActive(){
        backgroundView.backgroundColor = UIColor(named: "HeavyTurquoise")!
    }
}
