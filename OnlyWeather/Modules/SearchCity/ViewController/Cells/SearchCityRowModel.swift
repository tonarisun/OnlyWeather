//
//  SearchCityRowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class SearchCityRowModel: RowModel {
    
    var cityName: String = ""
    var inMyCities: Bool = false
    
    init(with city: City) {
        self.cityName = UserDefaults.standard.bool(forKey: Constants.isRussianLanguage) ? city.cityNameRUS : city.cityName
        super.init()
        self.id = city.cityID
    }
    
    required init(id: String) {
        super.init(id: UUID().uuidString)
    }
}
