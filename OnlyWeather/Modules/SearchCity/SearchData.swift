//
//  SearchData.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class SearchData {
    
    var cities = [City]()
    var filteredCities = [City]()
    var language = UserDefaults.standard.bool(forKey: Constants.isRussianLanguage) ? "ru" : ""
}
