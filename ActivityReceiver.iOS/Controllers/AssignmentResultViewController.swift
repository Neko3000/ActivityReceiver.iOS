//
//  ResultViewController.swift
//  
//
//  Created by Xueliang Chen on 11/1/18.
//

import UIKit
import Alamofire

class AssignmentResultViewController: UIViewController {
    
    var exerciseID:Int = 0
    
    // Outlets
    @IBOutlet weak var assignmentResultTableView: AssignmentResultTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadAssignmentResult()
    }
    
    func loadAssignmentResult(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ActiveUserInfo.getToken(),
            ]
        
        let parameters:Parameters = [
            "exerciseID":exerciseID,
            ]
        
        Alamofire.request(RemoteServiceManager.domain + "/MobileApplication/GetAssignmentResult", method: .post, parameters: parameters, encoding: JSONEncoding.default,headers:headers).responseJSON(completionHandler:{
                response in
                        
                switch(response.result){
                    
                case .success(let json):
                    
                    let dict = json as! [String:Any]
                    
                    self.assignmentResultTableView.assignmentResultViewModel = AssignmentResultViewModel(accuracyRate: (dict["accuracyRate"] as! NSNumber).floatValue, assignmentResultAnswerDetails:
                        DictionaryHandler.convertFromDictionaryArray(dictionaryArray: dict["answerDetails"] as! NSArray))

                    self.assignmentResultTableView.reloadData()
                    break
                    
                case .failure(let json):
                    
                    let dict = json as! [String:Any]
                    print(dict["message"] as! String)
                    
                    break
                }
                
        })
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
