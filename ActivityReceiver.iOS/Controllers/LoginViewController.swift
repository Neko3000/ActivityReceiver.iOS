//
//  LoginViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/21/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    // The information of current user
    private var currentUserInfo:UserInfo?

    // Outlets
    @IBOutlet weak var toSignUpBtn: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Styles
        
        toSignUpBtn.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        toSignUpBtn.layer.cornerRadius = 8.0
        toSignUpBtn.layer.masksToBounds = true
        
        usernameTextField.layer.cornerRadius = 19.0
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        usernameTextField.layer.masksToBounds = true
        usernameTextField.delegate = self
        
        passwordTextField.layer.cornerRadius = 19.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        passwordTextField.layer.masksToBounds = true
        passwordTextField.delegate = self

        loginBtn.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Try to login automatically
        initUserStatus()
    }
    
    func initUserStatus(){
        
        // Try to load UserInfo stored in bundle
        if let loadedUserInfo = UserInfo.loadUserInfo(){
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer " + loadedUserInfo.token,
                ]
            
            AlamofireManager.sharedSessionManager.request(RemoteServiceManager.domain + "/UserToken/Authorize", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {
                response in
                
                switch(response.result){
                    
                case .success(_):
                    
                    ActiveUserInfo.setUsername(username: loadedUserInfo.username)
                    ActiveUserInfo.setToken(token: loadedUserInfo.token)
                    
                    // Auto-Login
                    self.performSegue(withIdentifier: "LoginToUserCenter", sender: nil)
                    
                    break
                    
                case .failure(let json):
                    
                    let dict = json as! [String:Any]
                    print(dict["message"] as! String)
                    
                    break
                }
                
            })
        }
    }
    
    @IBAction func loginSubmit(_ sender: Any) {
    
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        //generate json contains username and password
        let parameters:Parameters = [
            "username":username ?? "",
            "password":password ?? ""
        ]

        AlamofireManager.sharedSessionManager.request(RemoteServiceManager.domain + "/UserToken/GetToken", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                response in
                
                switch(response.result){
                    
                case .success(let json):
                    
                    let dict = json as! [String:Any]
                    
                    let username = dict["username"] as! String
                    let token = dict["token"] as! String
                    
                    let userInfo = UserInfo(username: username, token: token)
                    UserInfo.saveUserInfo(userInfoObject: userInfo)
                    
                    ActiveUserInfo.setUsername(username: username)
                    ActiveUserInfo.setToken(token: token)
                    
                    // Segue to UserCenter
                    self.performSegue(withIdentifier: "LoginToUserCenter", sender: nil)
                    
                    break
                    
                case .failure(let json):
                    
                    let dict = json as! [String:Any]
                    print(dict["message"] as! String)
                    
                    break
                }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "LoginToUserCenter"){
            let dest = segue.destination as! UserCenterViewController
            
            dest.username = ActiveUserInfo.getUsername()
        }
    }
    
    // These functions are used to set the behavior of the keyboard when user try to dismiss it
    // Tap return button to dismiss
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Tap the area on the outside of keyboard to dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
