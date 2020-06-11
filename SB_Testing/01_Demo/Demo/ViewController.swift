//
//  ViewController.swift
//  Demo
//
//  Created by Ivan Akulov on 04/10/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private(set) var volume = 0
    
    //Устанавливаем громкость 0-100
    func setVolume(value: Int) {
        volume = min(max(value, 0), 100)
    }
    
    //Сравнение символов
    func charactersCompare(stringOne: String, stringTwo: String) -> Bool {
        return Set(stringOne) == Set(stringTwo)
    }
}

