//
//  LoginViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/21/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import Foundation

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
        
        //saveUserInfo()
        loadUserInfo()
    }
    
    @IBAction func loginSubmit(_ sender: Any) {
        
        print("login goes")
        
        let username = usernameTextField.text
        let password = passwordTextField.text
    }
    
    func saveUserInfo(){
        let myUserInfo = UserInfo(username: "jack", token: "thisIsMyToken")
        
        let codedMyUserInfo:Data = NSKeyedArchiver.archivedData(withRootObject: myUserInfo)
        let userDefaults = UserDefaults.standard
        userDefaults.set(codedMyUserInfo,forKey:"CurrentUserInfo")
        userDefaults.synchronize()
    }
    
    func loadUserInfo(){
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: "CurrentUserInfo") as! Data
        let myUserInfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfo
        
        print(myUserInfo.username)
        print(myUserInfo.token)
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
