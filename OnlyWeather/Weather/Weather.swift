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

class Weather: Mappable {
    
    var temp = 0.0
    var pressure = 0.0
    var humidity = 0
    var windSpeed = 0.0
    var windDeg = 0.0
    var sky = ""
    var skyDescription = ""
    var date = ""
    var shortDate = ""
    var day = ""
    var time = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        temp <- map["main.temp"]
        pressure <- map["main.pressure"]
        humidity <- map["main.humidity"]
        windSpeed <- map["wind.speed"]
        windDeg <- map["wind.deg"]
        sky <- map["weather.0.main"]
        skyDescription <- map["weather.0.description"]
        date <- map["dt_txt"]
    }
}

class WeatherResponse: Mappable {
    
    var response = [Weather]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        response <- map["list"]
    }
}

class TodayWeather: Mappable {
    
    var temp = 0.0
    var tempMin = 0.0
    var tempMax = 0.0
    var pressure = 0.0
    var humidity = 0
    var windSpeed = 0.0
    var windDeg = 0.0
    var sky = ""
    var skyDescription = ""
    var sunrise = 0.0
    var sunset = 0.0
    var timezone = 0.0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        temp <- map["main.temp"]
        tempMin <- map["main.temp_min"]
        tempMax <- map["main.temp_max"]
        pressure <- map["main.pressure"]
        humidity <- map["main.humidity"]
        windSpeed <- map["wind.speed"]
        windDeg <- map["wind.deg"]
        sky <- map["weather.0.main"]
        skyDescription <- map["weather.0.description"]
        sunrise <- map["sys.sunrise"]
        sunset <- map["sys.sunset"]
        timezone <- map["timezone"]
    }
}
