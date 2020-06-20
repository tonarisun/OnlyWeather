//
//  CityRowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class CityRowModel: RowModel {
    
    var name = ""
    
    init(with city: City) {
        self.name = UserDefaults.standard.bool(forKey: Constants.isRussianLanguage) ? city.cityNameRUS : city.cityName
        super.init(id: city.cityID)
    }
    
    required init(id: String) {
        super.init(id: id)
    }
}
