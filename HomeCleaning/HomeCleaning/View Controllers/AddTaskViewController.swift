//
//  AddTaskViewController.swift
//  HomeCleaning
//
//  Created by Balor on 4/14/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    var editTask: Bool = false
    var name: String = ""
    var frequency: Int = 14
    var notification: Bool = false
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var frequencyNumberLabel: UILabel!
    @IBOutlet weak var notificicationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Task"
        
        taskNameTextField.text = name
        frequencyNumberLabel.text = "\(frequency)"
        notificicationSwitch.setOn(notification, animated: true)
    }
    
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
