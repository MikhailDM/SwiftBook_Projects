//
//  ViewController.swift
//  TConverter
//
//  Created by Mike on 06.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        //print("Slider Value Changed")
        let temperatureCelcius = Int(round(sender.value))
        celsiusLabel.text = "\(temperatureCelcius)ºC"
        
        let temperatureFahrenheit = Int(round(sender.value * 9 / 5) + 32)
        fahrenheitLabel.text = "\(temperatureFahrenheit)ºF"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

