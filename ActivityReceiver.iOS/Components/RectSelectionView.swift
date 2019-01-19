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
