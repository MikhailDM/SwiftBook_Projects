//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Mike on 28.01.2020.
//  Copyright © 2020 Mike Team. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    //Метод сохранения записи в базу Realm
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
    //Метод удаления записи из базы Realm
    static func deleteObject(_ place: Place){
        try! realm.write {
            realm.delete(place)
        }
    }
}
