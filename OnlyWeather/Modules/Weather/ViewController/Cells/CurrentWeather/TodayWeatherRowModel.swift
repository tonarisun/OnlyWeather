//
//  TodawWeatherRowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class TodayWeatherRowModel: RowModel {
    
    var temp: Int
    var windSpeed: Int
    var windDirection: Double
    var sunrise: String
    var sunset: String
    var sunriseInt: Int
    var sunsetInt: Int
    var timeInt: Int
    var humidity: Int
    var pressure: Int
    var sky: String
    var description: String
    
    init(with weather: TodayWeather) {
        self.temp = Int(weather.temp)
        self.windSpeed = Int(weather.windSpeed)
        self.windDirection = weather.windDeg
        self.sunrise = Service.getTimeFromUNIXTime(date: Double(weather.sunrise + weather.timezone))
        self.sunset = Service.getTimeFromUNIXTime(date: Double(weather.sunset + weather.timezone))
        self.sunriseInt = weather.sunrise
        self.sunsetInt = weather.sunset
        self.timeInt = Int(Date().timeIntervalSince1970)
        self.humidity = weather.humidity
        self.pressure = Int(weather.pressure / 1.333)
        self.description = weather.skyDescription
        self.sky = weather.sky
        super.init()
    }
    
    required init(id: String) {
        fatalError("init(id:) has not been implemented")
    }
}
