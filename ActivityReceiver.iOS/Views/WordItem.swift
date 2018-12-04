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
    
    // These two functions are used to set the alpha value of numbers, where are on the top of each WordItem
    public func showOrderNumber(){
        orderNumberLabel.alpha = 1.0
        
    }
    
    public func hideOrderNumber(){
        orderNumberLabel.alpha = 0
        
    }
    
}
