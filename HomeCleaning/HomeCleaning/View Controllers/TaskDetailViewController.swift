//
//  ToDoViewController.swift
//  HomeCleaning
//
//  Created by Balor on 4/11/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    var task: Task?
    let numSections = 4
    enum sectionID: Int {
        case name = 0, setting, done, reset
    }
    
    var editButton: UIBarButtonItem!
    
    @IBOutlet weak var visibleTableControl: UISegmentedControl!
    @IBOutlet weak var statusTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTask))
        self.navigationItem.rightBarButtonItem = editButton
        
//        editButton.isEnabled = false
        
        statusTable.delegate = self
        statusTable.dataSource = self
        statusTable.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func unwindToTaskDetail(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindToTaskDetail" {
            let addTaskVC = segue.source as! AddTaskViewController
            
            task?.name = addTaskVC.taskNameTextField.text!
            task?.frequency = addTaskVC.frequency
            task?.notification = addTaskVC.notificicationSwitch.isOn
            
            self.statusTable.reloadData()
        }
    }
    
    @objc func editTask() {
        performSegue(withIdentifier: "editTaskSegue", sender: self)
    }
    
    @objc func notificationSwitchChanged(mySwitch: UISwitch!) {
        task?.notification = !(task?.notification)!
            
        mySwitch.setOn((task?.notification)!, animated: true)
    }
    
    @objc func pauseSwitchChanged(mySwitch: UISwitch!) {
        task?.isPaused = !(task?.isPaused)!
        
        mySwitch.setOn((task?.isPaused)!, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTaskSegue" {
            let addTaskNav = segue.destination as! UINavigationController
            let addTaskVC = addTaskNav.viewControllers[0] as! AddTaskViewController
            addTaskVC.editTask = true
            addTaskVC.name = task?.name ?? ""
            addTaskVC.frequency = task?.frequency ?? 14
            addTaskVC.notification = task?.notification ?? false
        }
    }
}

extension TaskDetailViewController: UITableViewDelegate {
}

extension TaskDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionID.name.rawValue:
            return 2
            
        case sectionID.setting.rawValue:
            return 3
            
        case sectionID.done.rawValue:
            return 2
            
        case sectionID.reset.rawValue:
            return 1
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskIdentifier", for: indexPath)
        
        switch indexPath.section {
        case sectionID.name.rawValue:
            if indexPath.row == 0 {
                cell.textLabel?.text = task?.name
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Task is due in xx Day(s)"
            }
        
        case sectionID.setting.rawValue:
            // here is programatically switch make to the table view
            let switchView = UISwitch(frame: .zero)
            switchView.tag = indexPath.row // for detect which row switch Changed
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Due Every: \(task?.frequency ?? -1) Day(s)"
                
                cell.accessoryView = nil
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Due Date Alert"
                
                switchView.setOn((task?.notification)!, animated: true)
                switchView.addTarget(self, action: #selector(notificationSwitchChanged), for: .valueChanged)
                cell.accessoryView = switchView
            } else {
                cell.textLabel?.text = "Pause Task"
                
                switchView.setOn((task?.isPaused)!, animated: true)
                switchView.addTarget(self, action: #selector(pauseSwitchChanged), for: .valueChanged)
                cell.accessoryView = switchView
            }
        
        case sectionID.done.rawValue:
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = self.view.tintColor
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Just Finished Task"
            } else {
                cell.textLabel?.text = "Finished Task On..."
            }
        
        case sectionID.reset.rawValue:
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            cell.textLabel?.text = "Reset Timer"
            
        default:
            cell.textLabel?.text = "TBD"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        switch section {
        case sectionID.name.rawValue:
            title = "Task"
        
        case sectionID.setting.rawValue:
            title = "Settings"
           
        case sectionID.done.rawValue:
            title = "Finished Task"
            
        default:
            title = ""
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case sectionID.done.rawValue:
            return 55.0
            
        default:
            return 44.0
        }
    }
}

