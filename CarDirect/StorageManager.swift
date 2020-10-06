//
//  StorageManager.swift
//  CarDirect
//
//  Created by Apple on 05.10.2020.
//  Copyright © 2020 Ilya Rozenko. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ car: CarInfo ){
        
        try! realm.write {
            realm.add(car)
        }
    }
    
    static func deleteObject (_ car: CarInfo) {
        
        try! realm.write {
            realm.delete(car)
        }
    }
}
