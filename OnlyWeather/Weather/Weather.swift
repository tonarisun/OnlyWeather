//
//  Weather.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class OneDayWeather : Mappable {
    
    var temp = 0.0
    var min_temp = 0.0
    var max_temp = 0.0
    var pressure = 0
    var humidity = 0
    var windSpeed = 0.0
    var windDeg = 0.0
    var windDirection = ""
    var sunrise = 0.0
    var sunset = 0.0
    var sky = ""
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        temp <- map["main.temp"]
        min_temp <- map["main.temp_min"]
        max_temp <- map["main.temp_max"]
        pressure <- map["main.pressure"]
        humidity <- map["main.humidity"]
        windSpeed <- map["wind.speed"]
        windDeg <- map["wind.deg"]
        sunrise <- map["sys.sunrise"]
        sunset <- map["sys.sunset"]
        sky <- map["weather.0.main"]
    }
}

