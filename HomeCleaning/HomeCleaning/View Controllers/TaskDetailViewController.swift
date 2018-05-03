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
        case task = 0, setting, done, reset
    }
    enum segmentID: Int {
        case status = 0, history
    }
    
    var editButton: UIBarButtonItem!
    
    @IBOutlet weak var visibleTableControl: UISegmentedControl!
    @IBOutlet weak var statusTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nav bar set up
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTask))
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.title = task?.name
        
        // table view setup
        statusTable.delegate = self
        statusTable.dataSource = self
        statusTable.tableFooterView = UIView(frame: .zero)
        
        // segment control setup
        visibleTableControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
    }
    
    func taskFinished() {
        let alert = UIAlertController(title: "Complete Task?", message: "This action can not be undo.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
            self.task?.taskCompleted()
            
            self.statusTable.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetTaskTimer() {
        let alert = UIAlertController(title: "Reset Task Timer?", message: "This action can not be undo.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.task?.taskReset()
            
            self.statusTable.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Objc Functions
    @objc func updateTable(mySegmentedControl: UISegmentedControl) {
        if mySegmentedControl.selectedSegmentIndex == segmentID.status.rawValue {
            editButton.isEnabled = true
        } else if mySegmentedControl.selectedSegmentIndex == segmentID.history.rawValue {
            editButton.isEnabled = false
        }
        
        statusTable.reloadData()
    }
    
    @objc func editTask() {
        performSegue(withIdentifier: "editTaskSegue", sender: self)
    }
    
    @objc func notificationSwitchChanged(mySwitch: UISwitch!) {
        task?.notification = mySwitch.isOn
    }
    
    @objc func pauseSwitchChanged(mySwitch: UISwitch!) {
        task?.isPaused = mySwitch.isOn
    }
    
    // MARK: - Navigation
    @IBAction func unwindToTaskDetail(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindToTaskDetail" {
            let addTaskVC = segue.source as! AddTaskViewController
            
            task?.name = addTaskVC.taskNameTextField.text!
            task?.frequency = addTaskVC.frequency
            task?.priorityWeight = addTaskVC.prioritySegment.selectedSegmentIndex + 1
            
            self.statusTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTaskSegue" {
            let addTaskNav = segue.destination as! UINavigationController
            let addTaskVC = addTaskNav.viewControllers[0] as! AddTaskViewController
            addTaskVC.editTask = true
            addTaskVC.name = task?.name ?? ""
            addTaskVC.frequency = task?.frequency ?? 14
            addTaskVC.priorityWeight = task?.priorityWeight ?? 1
        }
    }
}

// MARK: - UITableViewDelegate
extension TaskDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == sectionID.done.rawValue {
            self.taskFinished();
        } else if indexPath.section == sectionID.reset.rawValue {
            self.resetTaskTimer();
        }
    }
}

extension TaskDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections: Int = 1
        
        if visibleTableControl.selectedSegmentIndex == segmentID.status.rawValue {
            sections = numSections
        } else if visibleTableControl.selectedSegmentIndex == segmentID.history.rawValue {
            sections = 1
        }
        
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows: Int = 1
        
        if visibleTableControl.selectedSegmentIndex == segmentID.status.rawValue {
            switch section {
            case sectionID.task.rawValue:
                numOfRows = 1
                
            case sectionID.setting.rawValue:
                numOfRows = 4
                
            case sectionID.done.rawValue:
                numOfRows = 1
                
            case sectionID.reset.rawValue:
                numOfRows = 1
                
            default:
                numOfRows = 1
            }
        } else if visibleTableControl.selectedSegmentIndex == segmentID.history.rawValue {
            numOfRows = task?.history.count ?? 0
        }
        
        return numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskIdentifier", for: indexPath)
        
        if visibleTableControl.selectedSegmentIndex == segmentID.status.rawValue {
            switch indexPath.section {
            case sectionID.task.rawValue:
                cell.textLabel?.text = task?.name
                
                let subLabel = UILabel()
                subLabel.text = (task?.getRemainingTimeString())!
                subLabel.font = UIFont.systemFont(ofSize: 12)
                subLabel.sizeToFit()
                
                if (task?.isOverdue == true) {
                    subLabel.textColor = UIColor.red
                } else {
                    subLabel.textColor = UIColor.black
                }
                
                cell.accessoryView = subLabel
        
            case sectionID.setting.rawValue:
                // here is programatically switch make to the table view
                let switchView = UISwitch(frame: .zero)
                switchView.tag = indexPath.row // for detect which row switch Changed
                
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Due Every: \(task?.frequency ?? -1) Day(s)"
                    
                    cell.accessoryView = nil
                } else if indexPath.row == 1 {
                    cell.textLabel?.text = task?.getPriorityString()
                    
                    cell.accessoryView = nil
                } else if indexPath.row == 2 {
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
                cell.textLabel?.text = "Task Finished"
            
            case sectionID.reset.rawValue:
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                cell.textLabel?.text = "Reset Task Timer"
                
            default:
                cell.textLabel?.text = "TBD"
            }
        } else if visibleTableControl.selectedSegmentIndex == segmentID.history.rawValue {
            cell.textLabel?.text = task?.getHistoryIndexString(index: indexPath.row)
            cell.accessoryView = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        if visibleTableControl.selectedSegmentIndex == segmentID.status.rawValue {
            switch section {
            case sectionID.task.rawValue:
                title = "Task"
            
            case sectionID.setting.rawValue:
                title = "Settings"
               
            case sectionID.done.rawValue:
                title = "Finished Task"
                
            default:
                title = ""
            }
        } else if visibleTableControl.selectedSegmentIndex == segmentID.history.rawValue {
            title = "History"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 44.0
        if visibleTableControl.selectedSegmentIndex == segmentID.status.rawValue {
            switch indexPath.section {
            case sectionID.done.rawValue:
                height = 55.0
                
            default:
                height = 44.0
            }
        } else if visibleTableControl.selectedSegmentIndex == segmentID.history.rawValue {
            height = 44.0
        }
        
        return height
    }
}

