//
//  ViewController.swift
//  UIPageView
//
//  Created by Debash on 29.05.2018.
//  Copyright © 2018 swiftbook.ru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        startPresentation()
        if let pageViewController = storyboard?.instantiateViewController(
            withIdentifier: "PageViewController") as? PageViewController {
            
            self.present(pageViewController, animated: true, completion: nil)
        }
    }

    // Презентация при первом запуске
    func startPresentation() {
        
        let userDefaults = UserDefaults.standard
        let appAlreadeSeen = userDefaults.bool(forKey: "appAlreadeSeen")
        if appAlreadeSeen == false {

            // Отображение PageViewController
            if let pageViewController = storyboard?.instantiateViewController(
                withIdentifier: "PageViewController") as? PageViewController {

                self.present(pageViewController, animated: true, completion: nil)
            }
        }
    }


}

