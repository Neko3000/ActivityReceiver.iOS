//
//  ActivityIndicatorOverlayView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/13/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class ActivityIndicatorOverlayView:XibUIView{
    
    // Outlets
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    private var isInitialized:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            backgroundView.backgroundColor = UIColor(named: "NormalGrey")?.withAlphaComponent(0.4)
            
            activityIndicatorView.startAnimating()
        }
        
    }
    
    public func showActivityIndicatorView(){
        activityIndicatorView.alpha = 1
    }
    
    public func hideActivityIndiactorView(){
        activityIndicatorView.alpha = 0
    }
}
