//
//  Task.swift
//  ToDoApp
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    let date: Date
    let location: Location?
    
    init(title: String, description: String? = nil,
         date: Date? = nil,
         location: Location? = nil) {
        self.title = title
        self.description = description
        self.date = date ?? Date()
        self.location = location
    }
}

//Сравнение 2х обьектов
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        guard
            rhs.title == lhs.title &&
            lhs.description == rhs.description &&
            rhs.location == lhs.location else { return false }
        return true
    }
}
