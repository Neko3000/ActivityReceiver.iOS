//
//  ResultViewController.swift
//  
//
//  Created by Xueliang Chen on 11/1/18.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var mainTableView: ResultTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //mainTableView.
        
        let resultAnswerDetail1 = ResultAnswerDetail(sentenceJP: "あなたのしっぽを触りたい.", sentenceEN: "I wanna touch your tail.", answer: "touch tail I wanna.", isCorrect: false)
        let resultAnswerDetail2 = ResultAnswerDetail(sentenceJP: "お主と出会うために生まれたんだ.", sentenceEN: "I was borned for you.", answer: "I was borned for you.", isCorrect: true)
        
        var resultAnswerDetails = [ResultAnswerDetail]()
        resultAnswerDetails.append(resultAnswerDetail1)
        resultAnswerDetails.append(resultAnswerDetail2)
        
        let resultVM = ResultViewModel()
        resultVM.accuracyRate = 79.3
        resultVM.resultAnswerDetails = resultAnswerDetails
        
        mainTableView.resultViewModel = resultVM
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
