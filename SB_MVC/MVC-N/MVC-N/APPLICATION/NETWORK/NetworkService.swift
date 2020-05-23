//
//  NetworkService.swift
//  MVC-N
//
//  Created by Михаил Дмитриев on 06.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments")!
class NetworkService {
    //Singleton
    private init() {}
    static let shared = NetworkService()
    //Метод получения информации по URL
    public func getData(url: URL, completion: @escaping (Any) -> ()) {
        //Создем сессию
        let session = URLSession.shared
        
        //Задача сессии
        session.dataTask(with: url) { (data, response, error) in
            //Ловим информацию
            guard let data = data else { return }
            
            do {
                //Декодируем данные
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print (json)
                //Передаем код дальше
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print (error)
            }
        }.resume()
    }
}
