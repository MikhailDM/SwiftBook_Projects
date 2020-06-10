//
//  ViewController.swift
//  UITextField
//
//  Created by Mike on 07.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func donePressed(_ sender: Any) {
        guard textField.text?.isEmpty == false else {return}
        if let _ = Double(textField.text!) {
            //Действия при ошибке
            let alert = UIAlertController(title: "WRONG FORMAT", message: "Please repeat again", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            present(alert, animated: true, completion: nil)
            alert.addAction(okAction)
            print("Name format is wrong")
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    
}

