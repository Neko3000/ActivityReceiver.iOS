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
    
    private var isInitialized:Bool = false
        
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet var mainContainerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            backgroundView.layer.cornerRadius = 5.0
            backgroundView.clipsToBounds = true
            
            hideOrderNumber()
            
            isInitialized = true
        }

    }
    
    public func showOrderNumber(){
        orderNumberLabel.alpha = 1.0
        
    }
    
    public func hideOrderNumber(){
        orderNumberLabel.alpha = 0
        
    }
    
}
