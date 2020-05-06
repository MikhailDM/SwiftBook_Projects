//
//  Box.swift
//  MVVM-2
//
//  Created by Михаил Дмитриев on 05.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//Класс дженерик
class Box<T> {
    
    typealias Listener = (T) -> ()
    
    //Наблюдатель. Принимает значение и ваыполняет действия
    var listener: Listener?
    
    //Значение за которым наблюдает наблюдатель
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    //Определяем что мы делаем при получении значения
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    //Инициализатор
    init(_ value: T) {
        self.value = value
    }
}
