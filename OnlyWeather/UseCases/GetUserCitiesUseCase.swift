//
//  GetUserCities.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import RealmSwift

protocol GetUserCitiesUseCase: class {
    
    func execute(completion: ([City]) -> ())
}

class GetUserCitiesUseCaseImpl: GetUserCitiesUseCase {
 
    func execute(completion: ([City]) -> ()) {

        var userCities = [City]()
        do {
            let realm = try Realm()
            let cities = realm.objects(City.self)
            cities.forEach { (city) in
                let userCity = City()
                userCity.cityID = city.cityID
                userCity.cityName = city.cityName
                userCity.cityNameRUS = city.cityNameRUS
                userCity.country = city.country
                userCity.isAdded = city.isAdded
                userCities.append(userCity)
            }
        } catch {
            print(error)
        }
        
        completion(userCities)
    }
}
