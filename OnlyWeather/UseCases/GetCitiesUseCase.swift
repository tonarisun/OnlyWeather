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

    func execute(completion: @escaping (Bool, [City]?) -> ())
}

class GetCitiesUseCaseImpl: GetCitiesUseCase {
    
    func execute(completion: @escaping (Bool, [City]?) -> ()) {
        Firestore.firestore().collection("cityList").getDocuments() { (querySnapshot, err) in
            
            guard let querySnpsht = querySnapshot else {
                print("Error getting documents: \(String(describing: err))")
                completion(false, nil)
                return
            }
            var cities = [City]()
            for document in querySnpsht.documents {
                  let city = City()
                  city.cityID = document.data()["cityID"] as! String
                  city.cityName = document.data()["cityName"] as! String
                  city.country = document.data()["country"] as! String
                  city.cityNameRUS = document.data()["cityNameRUS"] as! String
                  cities.append(city)
            }
            
            if UserDefaults.standard.bool(forKey: Constants.isRussianLanguage) {
                cities.sort { $0.cityNameRUS < $1.cityNameRUS }
            } else {
                cities.sort { $0.cityName < $1.cityName }
            }
            completion(true, cities)
        }
    }
}
