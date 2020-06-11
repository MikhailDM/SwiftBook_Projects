//
//  Location.swift
//  ToDoApp
//
//  Created by Михаил Дмитриев on 11.06.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    //Собственный ининциализатор
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}


//Сравнение 2х обьектов
extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard rhs.coordinate?.latitude == lhs.coordinate?.latitude &&
            lhs.coordinate?.longitude == rhs.coordinate?.longitude &&
            lhs.name == rhs.name else { return false }
        return true
    }
}
