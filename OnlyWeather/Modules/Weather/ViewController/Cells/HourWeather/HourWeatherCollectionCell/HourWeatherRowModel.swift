//
//  HourWeatherRowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class HourWeatherRowModel: RowModel {
    
    var time    = ""
    var timeInt = 0
    var temp    = 0
    var sky     = ""
    var description = ""
    
    init(with weather: Weather) {
        self.time    = "\(weather.time):00"
        self.timeInt = weather.time
        self.temp    = Int(weather.temp)
        self.sky     = weather.sky
        self.description = weather.skyDescription
        super.init()
    }
    
    required init(id: String) {
        fatalError("init(id:) has not been implemented")
    }
}
