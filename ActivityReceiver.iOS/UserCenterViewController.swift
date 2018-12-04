//
//  UserCenterViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/28/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class UserCenterViewController: UIViewController,SegueBehaviorObject {
    
    //
    public var username:String = ""
    
    // Outlets
    @IBOutlet weak var userAvatarReshapableImageView: ReshapableImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var assignmentFunctionListItem: FunctionListItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set user's information
        usernameLabel.text = username
        
        userAvatarReshapableImageView.setUIImage(image: UIImage(named: "user-avatar")!)
        userAvatarReshapableImageView.setCornerRadius(radius: userAvatarReshapableImageView.frame.width/2.0)
        
        assignmentFunctionListItem.setSegueBehavior(object: self, identifier: "ToSelectExercise")
    }
    
    // Segue, called in FunctionListView when tapped its items

    @IBAction func logout(_ sender: Any) {
        
        // Bundle
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: "CurrentUserInfo")
        
        ActiveUserInfo.clear()
        
        performSegue(withIdentifier: "LogoutFromUserCenter", sender: nil)
    }
    
    func segueToAnotherScreen(withIdentifier identifier: String, sender: Any?) {
        
        performSegue(withIdentifier: identifier, sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToSelectExercise"){
            
        }
        else if(segue.identifier == "LogoutFromUserCenter"){
            
        }
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
