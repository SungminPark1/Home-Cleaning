//
//  TaskTableViewController.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import UIKit

class AreaDetailTableViewController: UITableViewController {
    var area: Area?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = area?.name
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    @IBAction func unwindToAreaDetail(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindWithDoneTapped" {
            let addTaskVC = segue.source as! AddTaskViewController
            
            let name = addTaskVC.taskNameTextField.text
            let info = addTaskVC.info
            let notification = addTaskVC.notificicationSwitch.isOn
            
            area?.tasks.append(Task(name: name!, info: info, notification: notification))

            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (area?.tasks.count)! + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaTaskIdentifier", for: indexPath)
        
        if indexPath.row < (area?.tasks.count)! {
            cell.textLabel?.text = area?.tasks[indexPath.row].name
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.textAlignment = .left
        } else {
            cell.textLabel?.text = "+ Add Task"
            cell.textLabel?.textColor = self.view.tintColor
            cell.textLabel?.textAlignment = .center
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < (area?.tasks.count)! {
            return true
        } else {
            return false
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            area?.tasks.remove(at: indexPath.row)
            
            // update the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let taskToMove = area?.tasks.remove(at: fromIndexPath.row)
        area?.tasks.insert(taskToMove!, at: to.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < (area?.tasks.count)! {
            return true
        } else {
            return false
        }
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < (area?.tasks.count)! {
            performSegue(withIdentifier: "taskSegue", sender: self)
        } else {
            performSegue(withIdentifier: "addTaskSegue", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                guard selectedRow < (area?.tasks.count)! else {
                    print("row \(selectedRow) is not in Task!")
                    return
                }
                let TaskDetailVC = segue.destination as! TaskDetailViewController
                TaskDetailVC.task = area?.tasks[selectedRow]
            }
        } else if segue.identifier == "addTaskSegue" {
            
        }
    }

}
