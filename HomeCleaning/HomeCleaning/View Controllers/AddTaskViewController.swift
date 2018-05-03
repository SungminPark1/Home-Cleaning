//
//  AddTaskViewController.swift
//  HomeCleaning
//
//  Created by Sungmin on 4/14/18.
//  Copyright © 2018 Sungmin. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    var editTask: Bool = false
    var name: String = ""
    var frequency: Int = 14
    var priorityWeight = 1
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var frequencyNumberLabel: UILabel!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editTask {
            self.navigationItem.title = "Editing Task"
        } else {
            self.navigationItem.title = "New Task"
        }
        
        taskNameTextField.text = name
        frequencyNumberLabel.text = "\(frequency)"
        prioritySegment.selectedSegmentIndex = priorityWeight - 1
    }
    
    // MARK: - IB Actions
    @IBAction func cancelTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func doneTapped() {
        if editTask {
            performSegue(withIdentifier: "unwindToTaskDetail", sender: self)
        } else {
            performSegue(withIdentifier: "unwindToAreaDetail", sender: self)
        }
    }
    
    @IBAction func minusButton(_ sender: Any) {
        frequency += -1
        
        if frequency < 1 {
            frequency = 1
        }
        
        frequencyNumberLabel.text = "\(frequency)"
    }
    
    @IBAction func addButton(_ sender: Any) {
        frequency += 1
        
        if frequency > 30 {
            frequency = 30
        }
        
        frequencyNumberLabel.text = "\(frequency)"
    }
}
