//
//  ExerciseItemTableViewCell.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/5/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class ExerciseSelectorExerciseListItemTableViewCell: UITableViewCell {
    
    // ID
    public var id:Int = 0
    
    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkedImageView: UIImageView!
    @IBOutlet weak var blockBGView: UIView!
    
    private var isInitialized:Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            // Styles
            selectionStyle = .none
            
            blockBGView.layer.cornerRadius = 8
            blockBGView.layer.applySketchShadow(color: UIColor(named: "Shadow-LightTurquoise")!, alpha: 1.0, x: 2.0, y: 10.0, blur: 30.0, spread: 0)
            
            isInitialized = true
        }
        
    }
    
    // These functions are for controlling show/hide behavior of the checked image
    public func showCheckedImage(){
        checkedImageView.isHidden = false
    }
    
    public func hideCheckedImage(){
        checkedImageView.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
