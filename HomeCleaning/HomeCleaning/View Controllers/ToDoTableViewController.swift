//
//  ToDoTableViewController.swift
//  HomeCleaning
//
//  Created by Sungmin on 4/9/18.
//  Copyright © 2018 Sungmin. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var areas = [Area]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "To-Dos"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        areas = AreaData.sharedData.areas
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedSection = indexPath.section
            let selectedRow = indexPath.row
            guard selectedSection < AreaData.sharedData.areas.count else {
                print("row \(selectedSection) is not in Area!")
                return
            }
            guard selectedRow < AreaData.sharedData.areas[selectedSection].tasks.count else {
                print("row \(selectedRow) is not in Task!")
                return
            }
            let TaskDetailVC = segue.destination as! TaskDetailViewController
            TaskDetailVC.task = AreaData.sharedData.areas[selectedSection].tasks[selectedRow]
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return areas.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas[section].tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoIdentifier", for: indexPath)
        let task = areas[indexPath.section].tasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        
        // set up accessory view
        let subLabel = task.getTaskSubLabel()
        cell.accessoryView = subLabel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String?
        
        // only show header if it has task
        if section < areas.count && areas[section].tasks.count > 0{
            header = areas[section].name
        }
        
        return header
    }
}
