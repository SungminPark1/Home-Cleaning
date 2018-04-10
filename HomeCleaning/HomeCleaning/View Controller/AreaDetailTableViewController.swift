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
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = area?.name
        
        if (area?.tasks.count == 0) {
            area?.tasks.append(Task(name: "Clean", info: "Info About Cleaning"))
            area?.tasks.append(Task(name: "Sweep", info: "Info About Sweeping"))
            area?.tasks.append(Task(name: "Vacuum", info: "Info About Vacuuming"))
        }
    }

    // MARK: - Actions -
    @objc func addItem() {
        //performSegue(withIdentifier: myAddBookmarkSegue, sender: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (area?.tasks.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaTaskIdentifier", for: indexPath)

        cell.textLabel?.text = area?.tasks[indexPath.row].name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let taskToMove = area?.tasks.remove(at: fromIndexPath.row)
        area?.tasks.insert(taskToMove!, at: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            guard selectedRow < (area?.tasks.count)! else {
                print("row \(selectedRow) is not in parks!")
                return
            }
            let TaskDetailVC = segue.destination as! TaskDetailTableViewController
            TaskDetailVC.task = area?.tasks[selectedRow]
        }
    }

}
