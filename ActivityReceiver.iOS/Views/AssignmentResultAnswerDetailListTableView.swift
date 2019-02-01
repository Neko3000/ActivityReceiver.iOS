//
//  ResultAnswerDetailTableView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/1/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class AssignmentResultAnswerDetailListTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    // Data - ViewModel
    var getAssignmentResultGetVM:GetAssignmentResultGetViewModel?

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
            self.register(UINib(nibName: "AssignmentResultResultAnswerDetailListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "AssignmentResultResultAnswerDetailListItemTableViewCell")
            self.register(UINib(nibName: "AssignmentResultResultAnswerDetailListHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AssignmentResultResultAnswerDetailListHeaderTableViewCell")
            
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
            let specificCell = self.dequeueReusableCell(withIdentifier: "AssignmentResultResultAnswerDetailListHeaderTableViewCell") as! AssignmentResultResultAnswerDetailListHeaderTableViewCell
            
            // Settings
            specificCell.accuracyRateLabel.text = "\(getAssignmentResultGetVM!.accuracyRate * 100)%"
            
            cell = specificCell
        }
        else{
            
            let specificCell = self.dequeueReusableCell(withIdentifier: "AssignmentResultResultAnswerDetailListItemTableViewCell") as! AssignmentResultResultAnswerDetailListItemTableViewCell
            
            let currentResultAnswerDetail = getAssignmentResultGetVM?.assignmentResultAnswerDetails[indexPath.section - 1]
            specificCell.numberLabel.text = "No." + String(indexPath.section)
            specificCell.sentenceJPLabel.text = currentResultAnswerDetail?.sentenceJP
            specificCell.sentenceENLabel.text = currentResultAnswerDetail?.sentenceEN
            specificCell.answerLabel.text = currentResultAnswerDetail?.answer
            
            
            // If the answer is wrong, change images
            // NOTE: cause cells are reusable, if there is only one if without else
            // A right answer cell will use a old wrong answer cell's image and will never be set to right cell
            if(!(currentResultAnswerDetail?.isCorrect ?? false)){
                
                specificCell.setCorrectnessMarkImage(image:UIImage(named: "bg-mark-wrong")!)
                specificCell.setLeftFrameImage(image:UIImage(named: "left-frame-rapsberry")!)
            }
            else{
                
                specificCell.setCorrectnessMarkImage(image:UIImage(named: "bg-mark-right")!)
                specificCell.setLeftFrameImage(image:UIImage(named: "left-frame-aquamarine")!)
            }
            
            cell = specificCell
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.section != 0){
            
            let specificCell = cell as! AssignmentResultResultAnswerDetailListItemTableViewCell
            let currentResultAnswerDetail = getAssignmentResultGetVM?.assignmentResultAnswerDetails[indexPath.section - 1]
            
            if(!(currentResultAnswerDetail?.isCorrect ?? false)){
                specificCell.setCorrectnessMarkImage(image:UIImage(named: "bg-mark-wrong")!)
                specificCell.setLeftFrameImage(image:UIImage(named: "left-frame-rapsberry")!)
            }
        }
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
        if(getAssignmentResultGetVM != nil){
            return getAssignmentResultGetVM!.assignmentResultAnswerDetails.count + 1
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
