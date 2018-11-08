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
        
        let parameters:Parameters = [
            "exerciseID":exerciseID,
            ]
        
        Alamofire.request("http://118.25.44.137/Question/GetAssignmentResult", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                response in
                
                switch(response.result){
                    
                case .success(let json):
                    
                    let assignmentResult = json as! NSDictionary
                    self.assignmentResultTableView.assignmentResultViewModel = AssignmentResultViewModel(accuracyRate: assignmentResult["accuracyRate"] as? Float ?? 0, assignmentResultAnswerDetails: assignmentResult["assignmentResultAnswerDetails"] as! [AssignmentResultAnswerDetail])
                    
                    self.assignmentResultTableView.reloadData()
                    break
                    
                case .failure(let error):
                    print(error)
                    
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
