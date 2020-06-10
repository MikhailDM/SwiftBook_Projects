//
//  ViewController.swift
//  UIContainerView
//
//  Created by Debash on 25.05.2018.
//  Copyright © 2018 swiftbook.ru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.numberOfLines = 0
    }

}
