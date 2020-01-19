//
//  GetWeatherUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire

protocol GetWeatherUseCase: class {
    
    func execute(cityID: String, completion: @escaping (Bool, [Weather]?) -> ())
}

class GetWeatherUseCaseImpl: GetWeatherUseCase {
    
    func execute(cityID: String, completion: @escaping (Bool, [Weather]?) -> ()) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c").responseObject { (response: DataResponse<WeatherResponse>) in
            guard let weatherResponse = response.result.value else {
                completion(false, nil)
                return }
            let weathers = weatherResponse.response
            completion(true, weathers)
        }
    }
}
