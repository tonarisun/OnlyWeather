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
    
    //MARK: - getDayAndTime
    static func getDayAndTime(weatherList: [Weather]?, timezone: Int) -> [Weather] {
        let weather = weatherList
        for weatherItem in weather ?? [] {
            let charArray = Array(weatherItem.date)
            let dayArr = [charArray[8], charArray[9]]
            let monthArr = [charArray[5], charArray[6]]
            let timeArr = [charArray[11], charArray[12]]
            let tempDayArray = [charArray[8], charArray[9]]
            let timeInCurrentCityString = String(timeArr)
            let timeInCurrentCityInt = Int(timeInCurrentCityString)! + timezone
            let tempDayInt = Int(String(tempDayArray))
            if timeInCurrentCityInt >= 24 {
                weatherItem.time = timeInCurrentCityInt - 24
                weatherItem.tempDay = tempDayInt! + 1
            } else {
                if timeInCurrentCityInt < 0 {
                    weatherItem.time = timeInCurrentCityInt + 24
                    weatherItem.tempDay = tempDayInt! - 1
                } else {
                    weatherItem.time = timeInCurrentCityInt
                    weatherItem.tempDay = tempDayInt!
                }
            }
            weatherItem.day = Int(String(dayArr))!
            weatherItem.month = String(monthArr)
        }
        return weather ?? []
    }
    
    //MARK: - sortWeatherByDay
    static func sortWeatherByDay(weatherList: [Weather]?) -> [Weather] {
        return weatherList?.filter({ (weather) in
            (weather.time >= 13 && weather.time <= 15) || (weather.time >= 1 && weather.time <= 3)
        }) ?? []
    }
    
    //MARK: - checkTime
    static func checkTime(now: Int, nextTime: Int) -> Bool {
        return ((now >= 12 && now <= 16) && (nextTime >= 12 && nextTime <= 16)) || ((now >= 0 && now <= 4) && (nextTime >= 0 && nextTime <= 4))
    }
    
    //MARK: - getDaysOfWeek
    static func getDaysOfWeek(weatherArr: [Weather]) {
        
        for weather in weatherArr {
            let stringDate = weather.date
            let weatherDate = stringToDate(dateString: stringDate)
            let dayNumber = weatherDate.ow_numberOfWeekDay()
            weather.weekDay = getDayString(number: dayNumber ?? 0)
        }
    }
    
    //MARK: - getDayString
    static func getDayString(number: Int) -> String {
        switch number {
        case 1:
            return "sunday"
        case 2:
            return "monday"
        case 3:
            return "tuesday"
        case 4:
            return "wednesday"
        case 5:
            return "thursday"
        case 6:
            return "friday"
        case 7:
            return "saturday"
        default:
            return ""
        }
    }
    
    //MARK: - getTimeFromUNIXTime
    static func getTimeFromUNIXTime(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    //MARK: - getTimeFromUNIXInt
    static func getTimeFromUNIXInt(date: Int) -> Int? {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH"
        let intTime = Int(dateFormatter.string(from: date))
        return intTime
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
    
    //MARK: - stringToDate
    static func stringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}
