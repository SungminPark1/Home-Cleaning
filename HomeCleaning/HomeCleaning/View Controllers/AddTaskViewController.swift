//
//  AddTaskViewController.swift
//  HomeCleaning
//
//  Created by Balor on 4/14/18.
//  Copyright © 2018 Balor. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    var name: String = "New Task"
    var info: String = "Info on New Task"
    var frequency: Int = 14
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var frequencyNumberLabel: UILabel!
    @IBOutlet weak var notificicationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Task"
        
        frequencyNumberLabel.text = "\(frequency)"
    }
    
    @IBAction func cancelTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func minusButton(_ sender: Any) {
        frequency += -1
        
        if frequency < 0 {
            frequency = 0
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
