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
    var day = 0
    var month = ""
    var time = 0
    var weekDay = ""
    var tempDay = 0
    
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
