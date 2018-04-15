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
    let numSections = 3
    enum sectionID: Int {
        case name = 0, notification, info
    }
    
    @IBOutlet weak var visibleTableControl: UISegmentedControl!
    @IBOutlet weak var statusTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusTable.delegate = self
        statusTable.dataSource = self
        statusTable.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func switchChanged(mySwitch: UISwitch!) {
        task?.notification = !(task?.notification)!
            
        mySwitch.setOn((task?.notification)!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TaskDetailViewController: UITableViewDelegate {
}

extension TaskDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskIdentifier", for: indexPath)
        
        switch indexPath.section {
        case sectionID.name.rawValue:
            cell.textLabel?.text = task?.name
        
        case sectionID.notification.rawValue:
            cell.textLabel?.text = "Notification"
            
            // here is programatically switch make to the table view
            let switchView = UISwitch(frame: .zero)
            switchView.setOn((task?.notification)!, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            cell.accessoryView = switchView
            
        case sectionID.info.rawValue:
            cell.textLabel?.text = task?.info
            
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
        
        case sectionID.notification.rawValue:
            title = ""
            
        case sectionID.info.rawValue:
            title = "Info"
            
        default:
            title = "TBD"
        }
        
        return title
    }
    
}

