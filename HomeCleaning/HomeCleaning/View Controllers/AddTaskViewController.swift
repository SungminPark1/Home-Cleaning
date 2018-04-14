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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Task"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        // Do any additional setup after loading the view.
    }

    @objc func doneTapped() {
        performSegue(withIdentifier: "unwindWithDoneTapped", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
