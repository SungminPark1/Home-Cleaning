//
//  AreaTableViewController.swift
//  HomeCleaning
//
//  Created by Sungmin on 4/5/18.
//  Copyright © 2018 Sungmin. All rights reserved.
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
    
    override func viewDidAppear(_ animated: Bool) {
        areas = AreaData.sharedData.areas
        
        self.tableView.reloadSections([0], with: .automatic)
    }
    
    func createNewAreaAlert() {
        let alert = UIAlertController(title: "New Area", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Area Name"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            let firstTextField = alert.textFields![0] as UITextField
            
            // only create an area if its name is not an empty
            if let name = firstTextField.text {
                if name != "" {
                    self.areas.append(Area(name: name, tasks: [Task]()))
                    
                    AreaData.sharedData.areas = self.areas
                    
                    self.saveData()
                }
            }
            
            self.tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Load & Save
    func loadData() {
        // Load from a JSON file
        let decoder = JSONDecoder()
        let url = FileManager.filePathInDocumentsDirectory(filename: "data.json")
        do {
            let data = try Data.init(contentsOf: url)
            areas = try decoder.decode(Array<Area>.self, from: data)
            
            AreaData.sharedData.areas = areas
        } catch {
            print("Error loading Data: \(error)")
        }
    }
    
    func saveData() {
        let url = FileManager.filePathInDocumentsDirectory(filename: "data.json")
        
        // Saving to Disk in JSON format
        let encoder = JSONEncoder()
        do {
            let dataToSave = try encoder.encode(AreaData.sharedData.areas)
            
            try dataToSave.write(to: url)
        } catch {
            print("Error: \(error)")
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
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < areas.count {
            performSegue(withIdentifier: "areaDetailSegue", sender: self)
        } else {
            createNewAreaAlert()
        }
    }
    
    // MARK: - Table View Data Source
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
            
            progressView.progress = areas[indexPath.row].getProgressPercent()
            cell.accessoryView = progressView
        } else {
            cell.textLabel?.text = "+ Add Area"
            cell.textLabel?.textColor = self.view.tintColor
            cell.textLabel?.textAlignment = .center
            
            cell.accessoryView = nil
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
            
            AreaData.sharedData.areas = self.areas
            
            self.saveData()

            // update the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //
        }
    }
}
