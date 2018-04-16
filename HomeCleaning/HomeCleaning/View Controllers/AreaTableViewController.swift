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
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadData()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func loadData() {
        areas.append(Area(name: "Bedroom", tasks: [Task]()))
        areas.append(Area(name: "Living Room", tasks: [Task]()))
        areas.append(Area(name: "Kitchen", tasks: [Task]()))
        
        AreaData.sharedData.areas = areas
    }

    func createTextBoxAlert(title: String, placeHolder: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = placeHolder
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            let firstTextField = alert.textFields![0] as UITextField
            
            if let name = firstTextField.text {
                if name != "" {
                    self.areas.append(Area(name: name, tasks: [Task]()))
                    
                    AreaData.sharedData.areas = self.areas
                }
            }
            
            self.tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaIdentifier", for: indexPath)

        if indexPath.row < areas.count {
            cell.textLabel?.text = areas[indexPath.row].name
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.textAlignment = .left
            
            // add progressView to Cell
            let progressView = UIProgressView(progressViewStyle: .default)
//            progressView.tintColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)
            progressView.progress = 0.5
            
            cell.accessoryView = progressView
        } else {
            cell.textLabel?.text = "+ Add Area"
            cell.textLabel?.textColor = self.view.tintColor
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < areas.count {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            areas.remove(at: indexPath.row)
            
            // update the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < areas.count {
            performSegue(withIdentifier: "areaDetailSegue", sender: self)
        } else {
            createTextBoxAlert(title: "New Area", placeHolder: "Area Name")
        }
    }
    
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
