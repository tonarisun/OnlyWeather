//
//  UpdateCurrentCityUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol UpdateCurrentCityUseCase: class {
    
    func execute(city: City, completion: (Bool) -> ())
}

class UpdateCurrentCityUseCaseImpl: UpdateCurrentCityUseCase {
    
    func execute(city: City, completion: (Bool) -> ()) {
        let currentCity = CurrentCity()
        currentCity.cityID = city.cityID
        currentCity.cityNameRUS = city.cityNameRUS
        currentCity.cityName = city.cityName
        currentCity.country = city.country
        currentCity.isAdded = true
        RealmHelper().addItemToMyCities(city: city)
        RealmHelper().updateCurrentCity(city: currentCity)
        completion(true)
    }
}
