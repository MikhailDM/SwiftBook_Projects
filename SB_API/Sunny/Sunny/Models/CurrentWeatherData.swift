//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by Ivan Akulov on 05/03/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
//Структура данных JSON
struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    //Изменение ключа по которому мы получаем значения JSON
    //feels_like - в исходнике
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
