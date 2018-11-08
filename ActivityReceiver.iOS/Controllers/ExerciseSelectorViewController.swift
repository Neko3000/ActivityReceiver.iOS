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
    var firstQuestionDetail:QuestionDetail?
    
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
        
        Alamofire.request("http://118.25.44.137/Question/GetExerciseList").responseJSON(completionHandler: {
            response in
            
            switch(response.result){
                
            // Json data is not needed here
            case .success(let json):
                
                let exerciseDetails = json as! NSArray
                self.exerciseListTableView.exerciseListViewModel = ExerciseListViewModel(exerciseDetails: exerciseDetails as! [ExerciseDetail])
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
    
    func executedFunction(sender: Any?) {
        
        // Sender is the ID of the exercise
        //generate json contains username and password
        let parameters:Parameters = [
            "exerciseID":sender as! Int,
            ]
        
        Alamofire.request("http://118.25.44.137/Question/GetNextQuestion", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler:
            {
                response in
                
                switch(response.result){
                    
                case .success(let json):
                    
                    let dict = json as! NSDictionary
                    self.firstQuestionDetail = QuestionDetail(id: dict["id"] as! Int, sentenceJP: dict["sentenceJP"] as! String, division: dict["division"] as! String)
                    
                    self.present(self.alertDialog!, animated: true, completion: nil)
                    break
                    
                case .failure(let error):
                    print(error)
                    
                    break
                }
                
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "BeginToDoAssignment"){
            let dest = segue.destination as! MainViewController
            dest.currentQuestionDetail = firstQuestionDetail
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
