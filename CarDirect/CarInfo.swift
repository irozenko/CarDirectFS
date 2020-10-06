//
//  CarInfo.swift
//  CarDirect
//
//  Created by Apple on 04.10.2020.
//  Copyright © 2020 Ilya Rozenko. All rights reserved.
//

import RealmSwift

class CarInfo: Object {
    
    @objc dynamic var model = ""
    @objc dynamic var brand = ""
    @objc dynamic var type: String?
    @objc dynamic var year: String?
   
    convenience init (model: String, brand: String, type: String?, year: String?) {
        self.init()
        self.model = model
        self.brand = brand
        self.type = type
        self.year = year
    }
    
}
