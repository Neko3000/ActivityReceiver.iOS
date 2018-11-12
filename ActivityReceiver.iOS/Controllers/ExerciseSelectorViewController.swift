//
//  ExerciseSelectorViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/6/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import Alamofire

class ExerciseSelectorViewController: UIViewController,FunctionExecuteTarget {

    //
    var nextQuestionDetail:QuestionDetail?
    
    //
    var selectedExerciseDetail:ExerciseDetail?
    
    // AlertController
    var alertDialog:UIAlertController?
    
    // Outlets
    @IBOutlet weak var exerciseListTableView: ExerciseListTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadExercises()
        
        // Alert-Dialog
        alertDialog = UIAlertController(title: "確認", message: "解答を始めますか？", preferredStyle: .alert)
        alertDialog!.addAction(UIAlertAction(title: "はい", style:.default, handler: alertActionHandler(alertAction:)))
        alertDialog!.addAction(UIAlertAction(title: "いいえ", style:.cancel, handler: alertActionHandler(alertAction:)))
        
        exerciseListTableView.setFunctionExecuteTarget(target: self)
    }
    
    private func loadExercises(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ActiveUserInfo.userToken,
            ]
        
        Alamofire.request("http://118.25.44.137/Question/GetExerciseList", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {
            response in
            
            switch(response.result){
                
            case .success(let json):
                
                let dict = json as! NSDictionary
                let exerciseDetailsDict = dict["exerciseDetails"] as! [NSDictionary]
                
                var exerciseDetails = [ExerciseDetail]()
                for i in 0...exerciseDetailsDict.count - 1{
                    
                    exerciseDetails.append(ExerciseDetail(dict:exerciseDetailsDict[i]))
                }
                
                self.exerciseListTableView.exerciseListViewModel = ExerciseListViewModel(exerciseDetails: exerciseDetails)
                self.exerciseListTableView.reloadData()
                
                break
                
            case .failure(let error):
                print(error)
                
                break
            }
        })
    }
    
    private func alertActionHandler(alertAction:UIAlertAction){
        
        switch alertAction.style {
            
        case .default:
            
            // Call segue when tap on yes
            self.performSegue(withIdentifier: "BeginToDoAssignment", sender: nil)

            break
            
        case .cancel:
            print("cancel")
            break
            
        case .destructive:
            print("desturctive")
            break
            
        default:
            break
        }
    }
    
    // Sender is the chosen ExerciseDetail
    func executedFunction(sender: Any?) {
        
        // Convert
        let exerciseDetail = sender as! ExerciseDetail
        selectedExerciseDetail = exerciseDetail
        
        if(exerciseDetail.isFinished){
            
            performSegue(withIdentifier: "ShowAssignmentResult", sender: nil)
        }
        else{
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer " + ActiveUserInfo.userToken,
                ]
            
            // Generate json contains ExerciseID
            let parameters:Parameters = [
                "exerciseID":exerciseDetail.id,
                ]
            
            Alamofire.request("http://118.25.44.137/Question/GetNextQuestion", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON(completionHandler:
                {
                    response in
                    
                    switch(response.result){
                    case .success(let json):
                        
                        let dict = json as! NSDictionary
                        self.nextQuestionDetail = QuestionDetail(dict: dict)
                        
                        self.present(self.alertDialog!, animated: true, completion: nil)
                        break
                        
                    case .failure(let error):
                        print(error)
                        
                        break
                    }
                    
            })
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Fill data in question for MainViewController
        if(segue.identifier == "BeginToDoAssignment"){
            let dest = segue.destination as! MainViewController
            
            dest.exerciseID = selectedExerciseDetail?.id ?? 0
            dest.currentQuestionDetail = nextQuestionDetail
        }
        else if(segue.identifier == "ShowAssignmentResult"){
            let dest = segue.destination as! AssignmentResultViewController
            
            // Sender is the chosen ExerciseDetail
            dest.exerciseID = selectedExerciseDetail?.id ?? 0
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
