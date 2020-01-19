//
//  GetCitiesUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit
import Firebase

protocol GetCitiesUseCase: class {

    func execute(completion: @escaping ([City]?) -> ())
}

class GetCitiesUseCaseImpl: GetCitiesUseCase {
    
    func execute(completion: @escaping ([City]?) -> ()) {
        Firestore.firestore().collection("cityList").getDocuments() { (querySnapshot, err) in
            
            guard let querySnpsht = querySnapshot else {
                print("Error getting documents: \(String(describing: err))")
                completion(nil)
                return
            }
            var cities = [City]()
            for document in querySnpsht.documents {
                  let cityName = document.data()["cityName"] as! String
                  let cityNameRUS = document.data()["cityNameRUS"] as! String
                  let cityID = document.data()["cityID"] as! String
                  let country = document.data()["country"] as! String
                  let city = City()
                  city.cityID = cityID
                  city.cityName = cityName
                  city.country = country
                  city.cityNameRUS = cityNameRUS
                  cities.append(city)
            }
            completion(cities)
        }
    }
}
