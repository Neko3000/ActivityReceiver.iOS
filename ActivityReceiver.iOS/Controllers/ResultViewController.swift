//
//  ResultViewController.swift
//  
//
//  Created by Xueliang Chen on 11/1/18.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: ResultTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //mainTableView.
        
        let resultAnswerDetail1 = ResultAnswerDetail(sentenceJP: "賢い人は探すより機会を作るのだ。", sentenceEN: "A wise man will make more opportunities than he finds.", answer: "A wise man will make more opportunities than he finds.", isCorrect: false)
        let resultAnswerDetail2 = ResultAnswerDetail(sentenceJP: "この問題を解決する方法がたくさんあります。", sentenceEN: "There are many ways to solve this problem.", answer: "A wise man will make more opportunities than he finds.", isCorrect: true)
        
        var resultAnswerDetails = [ResultAnswerDetail]()
        resultAnswerDetails.append(resultAnswerDetail1)
        resultAnswerDetails.append(resultAnswerDetail2)
        
        let resultVM = ResultViewModel()
        resultVM.accuracyRate = 79.3
        resultVM.resultAnswerDetails = resultAnswerDetails
        
        resultTableView.resultViewModel = resultVM
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
