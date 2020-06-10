//
//  ViewController.swift
//  UISwitch
//
//  Created by Mike on 07.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hideLabel: UILabel!     
    @IBOutlet weak var simpleSwitch: UISwitch!
    
    override func viewDidLoad() {
        simpleSwitch.isOn = false
    }
    
    @IBAction func switchActionNew(_ sender: UISwitch) {
        
        hideLabel.isHidden = !hideLabel.isHidden
    //UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        if sender.isOn {
            //hideLabel.isHidden = true
            label.text = "TEXT IS HIDDEN"
        } else {
            //hideLabel.isHidden = false
            label.text = "TEXT IS SHOW"
        }
    }
}

