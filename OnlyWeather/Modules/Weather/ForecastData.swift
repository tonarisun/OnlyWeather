//
//  ForecastData.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class ForecastData {
    
    var todayWeather = TodayWeather()
    var hoursForecast = [Weather]()
    var daysForecast = [Weather]()
    var userCity = CurrentCity()
}
