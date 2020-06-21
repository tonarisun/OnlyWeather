//
//  CurrentCity.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - CurrentCity
class CurrentCity: Object {
    
    @objc dynamic var cityID = ""
    @objc dynamic var cityName = ""
    @objc dynamic var cityNameRUS = ""
    @objc dynamic var country = ""
    @objc dynamic var isAdded = false
    
    static func == (lhs: CurrentCity, rhs: City) -> Bool {
        return lhs.cityID == rhs.cityID
    }
}
