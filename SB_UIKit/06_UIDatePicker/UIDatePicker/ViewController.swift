//
//  ViewController.swift
//  UIDatePicker
//
//  Created by Mike on 07.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var dateValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = Locale(identifier: "ru_RU")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateValue = dateFormatter.string(from: datePicker.date)
        label.text = dateValue
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        dateValue = dateFormatter.string(from: sender.date)
        //label.text = dateValue
    }
    
    @IBAction func writeDate(_ sender: UIButton) {
        label.text = dateValue
    }
    
}

