//
//  LoginViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/21/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var toSignUpBtn: UIButton!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toSignUpBtn.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        toSignUpBtn.layer.cornerRadius = 8.0
        toSignUpBtn.layer.masksToBounds = true
        
        usernameTextField.layer.cornerRadius = 19.0
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        usernameTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 19.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        passwordTextField.layer.masksToBounds = true

        loginBtn.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.layer.masksToBounds = true
        
        
        
        
        // Do any additional setup after loading the view.
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
