//
//  Service.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    
    // базовый URL сервиса
    let baseUrl = "https://api.openweathermap.org"
    // ключ для доступа к сервису
    let apiKey = "4142e9613cb27a38a3607937f747095c"
    
    // метод для загрузки данных, в качестве аргументов получает город
    func loadWeatherData(city: String) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?q=\(city)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c").responseJSON { repsonse in
            print(repsonse.value ?? "default value")
        }
    }
}
