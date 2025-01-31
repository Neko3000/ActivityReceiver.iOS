//
//  QuestionSurveyView.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 1/23/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ConfusionDegreeSurveyView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var confusionDegree: Int {
        get{
            return selectionTableView.indexPathForSelectedRow?.row ?? 0
        }
    }
    
    // Outlets
    @IBOutlet weak var selectionTableView: UITableView!
    
    private var isInitialized:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            selectionTableView.delegate = self
            selectionTableView.dataSource = self
            
            selectionTableView.allowsSelection = true
            selectionTableView.allowsMultipleSelection = false
            
            selectionTableView.separatorStyle = .none
            
            selectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            isInitialized = true
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        cell?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        cell?.accessoryType = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell!.selectionStyle = .none
        cell!.textLabel!.font = UIFont(name: cell!.textLabel!.font.fontName, size: 14)
        
        var descriptionText = ""
        switch indexPath.row {
        case 0:
            descriptionText = "ほとんど迷わなかった"
            break
        case 1:
            descriptionText = "少し迷った"
            break
        case 2:
            descriptionText = "かなり迷った"
            break
        case 3:
            descriptionText = "誤って決定ボタンを押した"
            break
        default:
            break
        }
        cell!.textLabel!.text = descriptionText
        
        return cell!
    }
    
    public func clearSelection() {
        if let indexPath = selectionTableView.indexPathForSelectedRow {
            selectionTableView.deselectRow(at: indexPath, animated: false)
            
            let cell = selectionTableView.cellForRow(at:indexPath)
            
            cell?.accessoryType = .none
        }
    }
    
}
