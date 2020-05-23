//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Ivan Akulov on 28/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation

protocol NetworkWeatherManagerDelegate: class {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather)
}

class NetworkWeatherManager {
    //Типы запросов
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    //ДЕЛЕГАТЫ
    //weak - чтобы избежать утечку памяти
    weak var delegate: NetworkWeatherManagerDelegate?
    
    //КЛОУЖЕРЫ
    //CurrentWeather - тип, ничего не возвращает
    //var onCompletion: ((CurrentWeather) -> Void)?
    
    //Текущая погода c использованием текущего типа данных
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
            
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    //Запрос
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    //КЛОУЖЕРЫ
                    //Передаем текущую погоду через клоужер в случае получения данных
                    //self.onCompletion?(currentWeather)
                    
                    //ДЕЛЕГАТЫ
                    self.delegate?.updateInterface(self, with: currentWeather)
                }
            }
        }
        task.resume()
    }
    //Парсинг
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            //Создаем модель погоды. Инициализатор автоматически все заполняет
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
