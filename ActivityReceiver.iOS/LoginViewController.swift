//
//  LoginViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/21/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import Foundation
import JWTDecode
import Alamofire

class LoginViewController: UIViewController {
    
    private var currentUserInfo:UserInfo?

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
        
        //initUserState()

    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initUserState()
    }
    
    @IBAction func loginSubmit(_ sender: Any) {
        
    
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        //generate json contains username and password
        let parameters:Parameters = [
            "Username":username,
            "Password":password
        ]

        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                response in
                
                if let json = response.result.value {
                    
                    let dict = json as! NSDictionary
                    
                    let username = dict["username"] as! String
                    let token = dict["token"] as! String
                    
                    let userInfo = UserInfo(username: username, token: token)
                    self.saveUserInfo(userInfoObject: userInfo)
                    
                    //segue
                }
                
        })
    }
    
    func initUserState(){
        
        var isUserAuthorized = false
        
        if let loadedUserInfo = loadUserInfo(){
            
            do{
                let jwtToken = try decode(jwt: loadedUserInfo.token)
                if(!jwtToken.expired){
                    // test to server
                    isUserAuthorized = true
                }
            }
            catch{
                print(error)
            }
        }

        if(isUserAuthorized){
            
            performSegue(withIdentifier: "LoginToUserCenter", sender: nil)
        }
    }
    
    func saveUserInfo(userInfoObject:UserInfo){
        
        let codedMyUserInfo:Data = NSKeyedArchiver.archivedData(withRootObject: userInfoObject)
        let userDefaults = UserDefaults.standard
        userDefaults.set(codedMyUserInfo,forKey:"CurrentUserInfo")
        
        userDefaults.synchronize()
        
    }
    
    func loadUserInfo() -> UserInfo?{
        let userDefaults = UserDefaults.standard
        
        if let originalObject = userDefaults.object(forKey: "CurrentUserInfo"){
            let decodedData = originalObject as! Data
            let userInfo = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! UserInfo
            
            return userInfo
        }
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "LoginToUserCenter"){
            print("seuged")
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
