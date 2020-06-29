//
//  CurrentCityTime.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 29.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class CurrentCityTime {
    
    var now: Int = 0
    var day: Int = 0
    var night: Int = 0
    var currentTimezone: Int = 0
    
    static let instance = CurrentCityTime()
}
