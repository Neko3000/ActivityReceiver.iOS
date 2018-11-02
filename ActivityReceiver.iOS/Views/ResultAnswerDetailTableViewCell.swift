//
//  ResultAnswerDetailTableViewCell.swift
//  
//
//  Created by Xueliang Chen on 10/30/18.
//

import UIKit

class ResultAnswerDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var sentenceJPLabel: UILabel!
    @IBOutlet weak var sentenceENLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correctnessMarkImageView: UIImageView!
    
    @IBOutlet weak var blockBGView: UIView!
    
        private var isInitialized:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            blockBGView.layer.cornerRadius = 8
            blockBGView.layer.applySketchShadow(color: UIColor(named: "Shadow-LightTurquoise")!, alpha: 1.0, x: 2.0, y: 10.0, blur: 30.0, spread: 0)
            
            isInitialized = true
        }
    }
    
    public func setCorrectnessMarkImage(image:UIImage){
        correctnessMarkImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
