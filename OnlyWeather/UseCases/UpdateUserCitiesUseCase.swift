//
//  UpdateUserCitiesUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol UpdateUserCitiesUseCase: class {
    
    func execute(city: City, completion: (Bool) -> ())
}

class UpdateUserCitiesUseCaseImpl: UpdateUserCitiesUseCase {
    
    func execute(city: City, completion: (Bool) -> ()) {
        RealmHelper().addItemToMyCities(city: city)
        completion(true)
    }
}
