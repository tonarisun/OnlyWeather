//
//  NEWHourWeatherRowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 28.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class NEWHourWeatherRowModel: RowModel {
    
    var temp = ""
    var pressure = 0
    var humidity = 0
    var windSpeed = 0
    var windDirection = 0.0
    var sky = ""
    var description = ""
    var time = 0
    var weekDay = ""
    var date = ""
    var isDay = false
    
    init(with weather: Weather) {
        self.temp = NSString(format:"%.1f", weather.temp) as String
        self.pressure = Int(weather.pressure / 1.333)
        self.humidity = weather.humidity
        self.windSpeed = Int(weather.windSpeed)
        self.windDirection = weather.windDeg
        self.description = weather.skyDescription
        self.time = weather.timeInt
        self.weekDay = weather.weekDay
        self.sky = weather.sky
        self.date = weather.datePretty
        self.isDay = weather.isDay
        super.init()
    }
    
    required init(id: String) {
        super.init(id: id)
    }
}
