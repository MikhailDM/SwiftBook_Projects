//
//  ViewController.swift
//  Pass Data Project
//
//  Created by Mike on 06.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var returnLabel: UILabel!
    
    //Переход от контроллера
    @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "detailSeque", sender: nil)
    }
    
    //Дает возможность перейти сразу на нужный Segue
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else {return}
        guard let svc = segue.source as? SecondViewController else {return}
        self.returnLabel.text = svc.label.text
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SecondViewController else {return}
        dvc.login = loginTF.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

