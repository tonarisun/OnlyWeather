//
//  GetTodayWeatherUseCase.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire

protocol GetTodayWeatherUseCase: class {

    func execute(cityID: String, completion: @escaping (Bool, TodayWeather?) -> ())
}

class GetTodayWeatherUseCaseImpl: GetTodayWeatherUseCase {
    
    func execute(cityID: String, completion: @escaping (Bool, TodayWeather?) -> ()) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?id=\(cityID)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c").responseObject { (response: DataResponse<TodayWeather>) in
            guard let todayWeather = response.result.value else {
                completion(false, nil)
                return }
            completion(true, todayWeather)
        }
    }
}
