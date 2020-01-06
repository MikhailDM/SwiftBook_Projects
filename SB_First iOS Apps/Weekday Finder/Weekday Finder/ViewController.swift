//
//  ViewController.swift
//  Weekday Finder
//
//  Created by Mike on 06.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //INTERFACE BUILDER Ссылки
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeekDay() {
        //Выбор текущего календаря
        let calendar = Calendar.current
        //Создание переменной компонентов даты
        var dateComponents = DateComponents()
        
        //Проверка что в полях содержится значение
        guard let day = dateTF.text, let month = monthTF.text, let year = yearTF.text else {return}
        dateComponents.day = Int(day)
        dateComponents.month = Int(month)
        dateComponents.year = Int(year)
        
        //Проверка на корректную дату
        guard let date = calendar.date(from: dateComponents) else {return}
        
        //Создание форматирования даты
        let dateFormatter = DateFormatter()
        //Перевод на русскйи язык
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        //Формат вывода - только неделя
        dateFormatter.dateFormat = "EEEE"
        
        //Получение даты из календаря
        let weekday = dateFormatter.string(from: date)
        let capitalizedWeekday = weekday.capitalized
        
        resultLabel.text = capitalizedWeekday
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

