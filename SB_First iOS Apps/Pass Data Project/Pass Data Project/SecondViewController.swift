//
//  SecondViewController.swift
//  Pass Data Project
//
//  Created by Mike on 06.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var login: String!
     @IBOutlet weak var label: UILabel!
       
       @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let login = login else {return}
        label.text = "Hello, \(login)"
    }

}
