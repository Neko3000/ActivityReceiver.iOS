//
//  RegisterViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/23/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Styles
        registerBtn.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        registerBtn.layer.cornerRadius = 8.0
        registerBtn.layer.masksToBounds = true
        
        usernameTextField.layer.cornerRadius = 19.0
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        usernameTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 19.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        passwordTextField.layer.masksToBounds = true
        
        passwordConfirmTextField.layer.cornerRadius = 19.0
        passwordConfirmTextField.layer.borderWidth = 1.0
        passwordConfirmTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        passwordConfirmTextField.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerSubmit(_ sender: Any) {
        
        print("register goes")
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
