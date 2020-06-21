//
//  DayWeatherRowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class DayWeatherRowModel: RowModel {
    
    var temp = ""
    var pressure = 0
    var humidity = 0
    var windSpeed = 0
    var windDirection = 0.0
    var description = ""
    var time = 0
    var weekDay = ""
    var month = ""
    var day = 0
    var sky = ""
    
    init(with weather: Weather) {
        self.temp = NSString(format:"%.1f", weather.temp) as String
        self.pressure = Int(weather.pressure / 1.333)
        self.humidity = weather.humidity
        self.windSpeed = Int(weather.windSpeed)
        self.windDirection = weather.windDeg
        self.description = weather.skyDescription
        self.time = weather.time
        self.weekDay = weather.weekDay
        self.month = weather.month
        self.day = weather.day
        self.sky = weather.sky
        super.init()
    }
    
    required init(id: String) {
        super.init(id: UUID().uuidString)
    }
}
