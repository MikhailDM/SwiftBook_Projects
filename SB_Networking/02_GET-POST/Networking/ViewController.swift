//
//  ViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 25/07/2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //GET Request
    @IBAction func getRequest(_ sender: Any) {
        //Валидность URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        //Сессия
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            //Проверка на информацию
            guard let response = response, let data = data else { return }
            
            print(response)
            print(data)
            //Переводим в JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    //POST Request
    @IBAction func postRequest(_ sender: Any) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        //Данные для сервера
        let userData = ["Course": "Networking", "Lesson": "GET and POST"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //Параметры запроса
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Изменяем данные в JSON
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        //Сессия
        let session = URLSession.shared
        //Метод задачи
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        } .resume()
    }
    
}

