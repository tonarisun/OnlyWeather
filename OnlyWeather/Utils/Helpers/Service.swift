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
    
    //MARK: - sortWeatherByDay
    static func sortWeatherByDay(weatherList: [Weather]?) -> [Weather] {
        return weatherList?.filter({ (weather) in
            (weather.timeInt >= 13 && weather.timeInt <= 15) || (weather.timeInt >= 1 && weather.timeInt <= 3)
        }) ?? []
    }
    
    //MARK: - checkTime
    static func checkTime(nextTime: Int) -> Bool {
        let now = CurrentCityTime.instance.now
        return ((now >= 12 && now <= 16) && (nextTime >= 12 && nextTime <= 16)) || ((now >= 0 && now <= 4) && (nextTime >= 0 && nextTime <= 4))
    }


    //MARK: - correctTime
    static func correctTime(time: Int) -> Int {
        var tempTime = time
        if time < 0 {
             tempTime += 24
         } else if time > 24 {
             tempTime -= 24
         }
        return tempTime
    }

    //MARK: - dateForWeatherItems
    public static func dateForWeatherItems(weathersList: [Weather], timezone: Int) {
        weathersList.forEach { (weatherItem) in
            let dateInt = weatherItem.dateInt + timezone
            weatherItem.datePretty = Date.getDateComponentFromUNIXTime(time: dateInt, type: .shortDate)
            weatherItem.timeInt    = Date.getTimeInt(date: dateInt) ?? 0
            weatherItem.weekDay    = Date.getDateComponentFromUNIXTime(time: dateInt, type: .weekDay)
            weatherItem.isDay      = weatherItem.timeInt > CurrentCityTime.instance.day && weatherItem.timeInt <= CurrentCityTime.instance.night
        }
    }
}
