//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Mike on 07.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        label.font = label.font.withSize(35)
        //label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
    }

    @IBAction func choiseSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .blue
        
        case 2:
        label.text = "The third segment is selected"
        label.textColor = .yellow
            
        default:
        print("Something Wrong")
        }
    }
    
}

