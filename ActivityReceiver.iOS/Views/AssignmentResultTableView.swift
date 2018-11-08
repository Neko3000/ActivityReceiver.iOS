//
//  ResultAnswerDetailTableView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/1/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class AssignmentResultTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    // Data - ViewModel
    var assignmentResultViewModel:AssignmentResultViewModel?

    private var isInitialized = false
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        
        // Initialization
        if(!isInitialized){
            
            // Styles
            self.separatorStyle = .none
            self.allowsSelection = false
            
            // Register custom .xib as reusable cells
            self.register(UINib(nibName: "ResultAnswerDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultAnswerDetailTableViewCell")
            self.register(UINib(nibName: "ResultHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultHeaderTableViewCell")
            
            // Delegates
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
        
        // The first section is the ResultHeader cell
        if(indexPath.section == 0){
            // Get reuseable cell
            let specificCell = self.dequeueReusableCell(withIdentifier: "ResultHeaderTableViewCell") as! ResultHeaderTableViewCell
            
            // Settings
            specificCell.accuracyRateLabel.text = String(assignmentResultViewModel!.accuracyRate) + "%"
            
            cell = specificCell
        }
        else{
            let specificCell = self.dequeueReusableCell(withIdentifier: "ResultAnswerDetailTableViewCell") as! ResultAnswerDetailTableViewCell
            
            let currentResultAnswerDetail = assignmentResultViewModel?.assignmentResultAnswerDetails[indexPath.section - 1]
            specificCell.numberLabel.text = "No." + String(indexPath.section)
            specificCell.sentenceJPLabel.text = currentResultAnswerDetail?.sentenceJP
            specificCell.sentenceENLabel.text = currentResultAnswerDetail?.sentenceEN
            specificCell.answerLabel.text = currentResultAnswerDetail?.answer
            
            if(!(currentResultAnswerDetail?.isCorrect ?? false)){
                specificCell.setCorrectnessMarkImage(image:UIImage(named: "bg-mark-wrong")!)
                specificCell.setLeftFrameImage(image:UIImage(named: "left-frame-rapsberry")!)
            }
            
            cell = specificCell
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // The height of the first section(ResultHeader) is 108
        if(indexPath.section == 0){
            return 108
        }
        
        // The height of ResultAnswerDetail cells are determined by itself(AutoLayout)
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // There are only 1 row in each section
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // The count of section are decieded by resultAnswerDetials which in the ViewModel
        if(assignmentResultViewModel != nil){
            return assignmentResultViewModel!.assignmentResultAnswerDetails.count + 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // To simulate the spacing, section's header is a transparent UIView
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
        
        // Top-margin for each cell
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // Bottom-margin for each cell
        return 15
    }
    
}
