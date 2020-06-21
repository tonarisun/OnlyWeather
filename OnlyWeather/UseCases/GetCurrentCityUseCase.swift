//
//  GetCurrentCityUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 21.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol GetCurrentCityUseCase: class {
    
    func execute(completion: (CurrentCity) -> ())
}

class GetCurrentCityUseCaseImpl: GetCurrentCityUseCase {
    
    func execute(completion: (CurrentCity) -> ()) {
        let helper = RealmHelper()
        let city = helper.loadCurrentCity()
        completion(city)
    }
}
