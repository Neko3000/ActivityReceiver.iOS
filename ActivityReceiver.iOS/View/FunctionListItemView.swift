//
//  FunctionListItemView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/28/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class FunctionListItemView: XibUIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var segueBehaviorObject:SegueBehaviorObject?
    private var segueIdentifier = ""
    
    private var tapGestureReconginzer:UITapGestureRecognizer?
    
    @IBOutlet weak var bgBlockView: UIView!
    @IBOutlet weak var blockShadowCasterView: UIView!
    
    private var isInitialized = false
    
    public func setSegueBehavior(object:SegueBehaviorObject,identifier:String){
        
        segueBehaviorObject = object
        segueIdentifier = identifier
    }
    
    @objc private func tapGestureRecongnizerHandler(reconginzer:UIPanGestureRecognizer){
        switch reconginzer.state {
        case .began:
            break
        case .changed:
            break
        case .ended:
            segueBehaviorObject?.segueToAnotherScreen(withIdentifier: segueIdentifier, sender: nil)
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            bgBlockView.layer.cornerRadius = 8.0
            bgBlockView.layer.applySketchShadow(color: UIColor(named: "Shadow-LightGrey")!, alpha: 0.5, x: 0, y: 10.0, blur: 30.0, spread: 0)
            
            tapGestureReconginzer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecongnizerHandler(reconginzer:)))
            bgBlockView.addGestureRecognizer(tapGestureReconginzer!)
            bgBlockView.isUserInteractionEnabled = true
            
            isInitialized = true
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
