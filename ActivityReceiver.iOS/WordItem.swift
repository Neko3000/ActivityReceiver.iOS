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
        
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.layer.cornerRadius = 5.0
        backgroundView.clipsToBounds = true
    }
    
}
