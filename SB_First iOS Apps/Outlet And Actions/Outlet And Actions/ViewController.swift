//
//  ViewController.swift
//  Outlet And Actions
//
//  Created by Mike on 06.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func changeTextInLabel(_ sender: UIButton) {
        label.text = "Hello World"
    }
    @IBAction func sayInConsole(_ sender: UIButton) {
        print("Hello World in the Console")
    }
}

