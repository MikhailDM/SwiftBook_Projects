//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Михаил Дмитриев on 03.06.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

//Класс загрузки и показа картинки по URL
class WebImageView: UIImageView {
    //Функция подгрузки изображения по URL
    func set(imageURL: String) {
        //Проверяем правильность ссылки
        guard let url = URL(string: imageURL) else { return }
        
        //Проверка на изображение в кеше
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            image = UIImage(data: cachedResponse.data)
            print("From Cache")
            return
        }
        
        print("From Internet")
        //Запрос по URL
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            //Обновление картинки в асинхронном режиме
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    //Кешируем информацию
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    //Функция кеширования информации
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {return}
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
