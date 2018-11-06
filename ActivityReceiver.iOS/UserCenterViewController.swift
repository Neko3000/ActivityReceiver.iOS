//
//  UserCenterViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/28/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class UserCenterViewController: UIViewController,SegueBehaviorObject {

    // Outlets
    @IBOutlet weak var userAvatarReshapableImageView: ReshapableImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var assignmentFunctionListItem: FunctionListItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set user's information
        userAvatarReshapableImageView.setUIImage(image: UIImage(named: "user-avatar")!)
        userAvatarReshapableImageView.setCornerRadius(radius: userAvatarReshapableImageView.frame.width/2.0)
        
        assignmentFunctionListItem.setSegueBehavior(object: self, identifier: "ToStartAssignment")
    }
    
    // Segue, called in FunctionListView when tapped its items
    func segueToAnotherScreen(withIdentifier identifier: String, sender: Any?) {
        performSegue(withIdentifier: identifier, sender: sender)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
