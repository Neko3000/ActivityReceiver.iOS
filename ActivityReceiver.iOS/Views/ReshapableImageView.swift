//
//  ReshapableImageUIView.swift
//  Zizhi.iOS
//
//  Created by Xueliang Chen on 5/25/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class ReshapableImageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // Content image
    private let mainImageView:UIImageView = UIImageView()
    
    private var isInitialized = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            mainImageView.frame = bounds
            mainImageView.layer.masksToBounds = true
            self.addSubview(mainImageView)
            
            isInitialized = true
        }
    }
    
    // These functions are used to set styles
    public func setUIImage(image:UIImage)
    {
        mainImageView.image = image
    }
    
    public func setCornerRadius(radius:CGFloat)
    {
        mainImageView.layer.cornerRadius = radius
        self.layer.cornerRadius = radius
    }
    
    public func setContentMode(contentMode:UIViewContentMode)
    {
        mainImageView.contentMode = contentMode
    }
}
