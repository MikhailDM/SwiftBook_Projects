//
//  ViewController+alertController.swift
//  Sunny
//
//  Created by Ivan Akulov on 25/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
//Расширение View UIAlertController
extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        //Случайный город на месте placeholder
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        //Кнопка поиска
        let search = UIAlertAction(title: "Search", style: .default) { action in
            //Текстовое поле
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                //self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        //Кнопка отмены
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //Добавляем кнопки и отображаем
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
