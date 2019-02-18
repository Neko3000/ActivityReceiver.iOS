//
//  RegisterViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/23/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    //
    var alertDialog:UIAlertController?

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
        usernameTextField.delegate = self
        
        passwordTextField.layer.cornerRadius = 19.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        passwordTextField.layer.masksToBounds = true
        passwordTextField.delegate = self
        
        passwordConfirmTextField.layer.cornerRadius = 19.0
        passwordConfirmTextField.layer.borderWidth = 1.0
        passwordConfirmTextField.layer.borderColor = UIColor(named: "LightGrey1")?.cgColor
        passwordConfirmTextField.layer.masksToBounds = true
        passwordConfirmTextField.delegate = self
        
        // Do any additional setup after loading the view.
        alertDialog = UIAlertController(title: "確認", message: "-", preferredStyle: .alert)
        alertDialog!.addAction(UIAlertAction(title: "はい", style:.default, handler: nil))
        
    }
    
    @IBAction func registerSubmit(_ sender: Any) {
        
        if(!validateInput()){
            return
        }
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        //generate json contains username and password
        let parameters:Parameters = [
            "username":username ?? "",
            "password":password ?? ""
        ]
        
        AlamofireManager.sharedSessionManager.request(RemoteServiceManager.domain + "/UserToken/Register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                response in
                
                switch(response.result){
                    
                case .success(_):
                    
                    self.performSegue(withIdentifier: "RegisterToLogin", sender: nil)
                    
                    break
                    
                case .failure(let json):
                    
                    let dict = json as! NSDictionary
                    
                    self.alertDialog!.message = dict["message"] as? String
                    self.present(self.alertDialog!, animated: true, completion: nil)
                    
                    break
                }
        })
    }
    
    private func validateInput() -> Bool{
        
        var isValiadated = true
        
        var alertMessage = ""
        
        if(usernameTextField.text == "" || passwordTextField.text == ""){
            
            isValiadated = false
            
            alertMessage = "username/password can not be empty"
            
        }
        else if(passwordTextField.text != passwordConfirmTextField.text){
            
            isValiadated = false
            
            alertMessage = "password is not matched"
            
            
        }
        else if(passwordTextField.text!.count < 6){
            
            isValiadated = false
            
            alertMessage = "password should be longer than 6"
            
        }
        
        if(!isValiadated){
            
            alertDialog!.message = alertMessage
            self.present(alertDialog!, animated: true, completion: nil)
        }

        return isValiadated
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
