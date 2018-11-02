//
//  ResultHeaderTableViewCell.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/2/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class ResultHeaderTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var accuracyRateLabel: UILabel!
    
    private var isInitialized:Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
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
