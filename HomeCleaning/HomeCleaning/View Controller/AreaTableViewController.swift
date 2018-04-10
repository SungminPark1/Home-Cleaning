//
//  AreaTableViewController.swift
//  HomeCleaning
//
//  Created by Balor on 4/5/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import UIKit

class AreaTableViewController: UITableViewController {
    var areas = [Area]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Areas"
            
        loadData()
    }
    
    func loadData() {
        areas.append(Area(name: "Bedroom", tasks: [Task]()))
        areas.append(Area(name: "Living Room", tasks: [Task]()))
        areas.append(Area(name: "Kitchen", tasks: [Task]()))
        
        AreaData.sharedData.areas = areas
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaIdentifier", for: indexPath)

        cell.textLabel?.text = areas[indexPath.row].name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            guard selectedRow < AreaData.sharedData.areas.count else {
                print("row \(selectedRow) is not in Area!")
                return
            }
            let AreaDetailVC = segue.destination as! AreaDetailTableViewController
            AreaDetailVC.area = AreaData.sharedData.areas[selectedRow]
        }
    }

}
