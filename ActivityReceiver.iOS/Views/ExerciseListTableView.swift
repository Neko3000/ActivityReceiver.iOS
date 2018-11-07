//
//  AssignmentListTableView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/5/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit

class ExerciseListTableView: UITableView,UITableViewDelegate,UITableViewDataSource {


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var isInitialized:Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            // Styles
            self.separatorStyle = .none
            self.allowsSelection = false
            
            // Register custom .xib as reusable cells
            self.register(UINib(nibName: "ExerciseListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseListItemTableViewCell")
            
            // Delegates
            
            self.delegate = self
            self.dataSource = self
            
            isInitialized = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        let specificCell = self.dequeueReusableCell(withIdentifier: "ExerciseListItemTableViewCell") as! ExerciseListItemTableViewCell
        specificCell.layer.zPosition = CGFloat(indexPath.section)
        
        cell = specificCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // Bottom-margin for each cell
        return 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
