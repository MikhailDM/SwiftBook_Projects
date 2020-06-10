//
//  ViewController.swift
//  Buttons and Labels
//
//  Created by Mike on 07.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Ссылки на обьекты
    @IBOutlet var actionsButtons: [UIButton]!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    //Действия при старте
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.isHidden = true
        label.font = label.font.withSize(35)
                
        button.isHidden = true
        
        for button in actionsButtons {
            
            button.setTitleColor(.blue, for: .normal)
            button.backgroundColor = .green
        }
        
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
    }
    
    //Действия при надатии кнопки
    @IBAction func pressedButton(_ sender: UIButton) {
        label.isHidden = false
        button.isHidden = false
        
        if sender.tag == 0 {
            label.text = "Hello World"
            label.textColor = .red
        } else if sender.tag == 1 {
            label.text = "HiThere"
            label.textColor = .blue
        } else if sender.tag == 2 {
            label.isHidden = true
            button.isHidden = true
        }
        
    }

}

