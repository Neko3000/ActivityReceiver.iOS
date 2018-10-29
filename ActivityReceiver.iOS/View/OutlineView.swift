//
//  OutlineView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/28/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class OutlineView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
        layer.backgroundColor = UIColor.clear.cgColor
        
        layer.cornerRadius = layer.frame.width/2.0
    }
}
