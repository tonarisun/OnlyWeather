//
//  City.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - City
class City: Object {
    
    @objc dynamic var cityID = ""
    @objc dynamic var cityName = ""
    @objc dynamic var cityNameRUS = ""
    @objc dynamic var country = ""
    @objc dynamic var isAdded = false
    
    static func == (lhs: City, rhs: City) -> Bool {
       return lhs.cityID == rhs.cityID
    }
    
    override static func primaryKey() -> String? {
        return "cityID"
    }
}
