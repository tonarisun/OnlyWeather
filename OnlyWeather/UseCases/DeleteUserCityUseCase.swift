//
//  DeleteUserCityUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol DeleteUserCityUseCase: class {
    
    func execute(cityID: String, completion: (Bool) -> ())
}

class DeleteUserCityUseCaseImpl: DeleteUserCityUseCase {
    
    func execute(cityID: String, completion: (Bool) -> ()) {
        RealmHelper().deleteCity(with: cityID)
        completion(true)
    }
}
