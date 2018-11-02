//
//  ResultAnswerDetailTableView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/1/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class ResultTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var resultViewModel:ResultViewModel?

    private var isInitialized = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        
        if(!isInitialized){
            self.separatorStyle = .none
            self.allowsSelection = false
            self.register(UINib(nibName: "ResultAnswerDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultAnswerDetailTableViewCell")
            self.register(UINib(nibName: "ResultHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultHeaderTableViewCell")
            self.delegate = self
            self.dataSource = self
            
            isInitialized = true
            
        }
        
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if(indexPath.section == 0){
            let specificCell = self.dequeueReusableCell(withIdentifier: "ResultHeaderTableViewCell") as! ResultHeaderTableViewCell
            
            specificCell.accuracyRateLabel.text = String(resultViewModel!.accuracyRate)
            
            cell = specificCell
        }
        else{
            let specificCell = self.dequeueReusableCell(withIdentifier: "ResultAnswerDetailTableViewCell") as! ResultAnswerDetailTableViewCell
            
            let currentResultAnswerDetail = resultViewModel?.resultAnswerDetails[indexPath.section - 1]
            specificCell.numberLabel.text = String(indexPath.section)
            specificCell.sentenceJPLabel.text = currentResultAnswerDetail!.sentenceJP
            specificCell.sentenceENLabel.text = currentResultAnswerDetail!.sentenceEN
            specificCell.answerLabel.text = currentResultAnswerDetail!.answer
            
            if(!currentResultAnswerDetail!.isCorrect){
                specificCell.setCorrectnessMarkImage(image:UIImage(named: "bg-mark-wrong")!)
            }
            
            cell = specificCell
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
            return 108
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (resultViewModel?.resultAnswerDetails.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //to simulate the spacing, section's header is a transparent UIView
        let tempView = UIView()
        tempView.backgroundColor = UIColor.clear
        return tempView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempView = UIView()
        tempView.backgroundColor = UIColor.clear
        return tempView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
}
