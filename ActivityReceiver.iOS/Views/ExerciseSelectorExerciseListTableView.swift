//
//  AssignmentListTableView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/5/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class ExerciseSelectorExerciseListTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    // The reference of the ViewContrller which contains this view
    private var functionExecuteTarget:FunctionExecuteTarget?
    
    // Data - ViewModel
    public var getExerciseListGetVM:GetExerciseListGetViewModel?
    
    private var isInitialized:Bool = false

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            // Styles
            self.separatorStyle = .none
            //self.allowsSelection = false
            
            // Register custom .xib as reusable cells
            self.register(UINib(nibName: "ExerciseSelectorExerciseListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseSelectorExerciseListItemTableViewCell")
            
            // Delegates
            
            self.delegate = self
            self.dataSource = self
            
            isInitialized = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        let specificCell = self.dequeueReusableCell(withIdentifier: "ExerciseSelectorExerciseListItemTableViewCell") as! ExerciseSelectorExerciseListItemTableViewCell
        
        // Z-Postion for each cell, this is for the shadows
        specificCell.layer.zPosition = CGFloat(indexPath.section)
        
        let currentExerciseDetail = getExerciseListGetVM?.exerciseDetails[indexPath.section]
        specificCell.id = currentExerciseDetail?.id ?? 0
        specificCell.nameLabel.text = currentExerciseDetail?.name
        specificCell.descriptionLabel.text = currentExerciseDetail?.description
        specificCell.currentStatusLabel.text = "\(currentExerciseDetail?.currentNumber ?? 0)/\(currentExerciseDetail?.totalNumber ?? 0)"
        
        if(!(currentExerciseDetail?.isFinished ?? false)){
            specificCell.hideCheckedImage()
        }
        
        cell = specificCell
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // The count of section are decieded by resultAnswerDetials which in the ViewModel
        if(getExerciseListGetVM != nil){
            return getExerciseListGetVM!.exerciseDetails.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // There are only 1 row in each section
        return 1
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
        if(section == 0){
            return 20
        }
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // Bottom-margin for each cell
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        functionExecuteTarget?.executedFunction(sender: getExerciseListGetVM?.exerciseDetails[indexPath.section])
        
    }
    
    public func setFunctionExecuteTarget(target:FunctionExecuteTarget){
        
        // Function called in ViewController
        functionExecuteTarget = target
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
