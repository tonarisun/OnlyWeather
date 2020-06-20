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
    
    func getDayAndTime(weatherList: [Weather], timezone: Int) -> [Weather] {
        let weather = weatherList
        for weatherItem in weather {
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
        return weather
    }
    
    func sortWeatherByDay(weatherList: [Weather]) -> [Weather] {
        var weatherByDay = [Weather]()
        for weather in weatherList {
            if (weather.time >= 13 && weather.time <= 15) || (weather.time >= 1 && weather.time <= 3) {
                weatherByDay.append(weather)
            }
        }
        return weatherByDay
    }
    
    func checkTime(now: Int, nextTime: Int) -> Bool {
        return ((now >= 12 && now <= 16) && (nextTime >= 12 && nextTime <= 16)) || ((now >= 0 && now <= 4) && (nextTime >= 0 && nextTime <= 4))
    }
    
    func getDaysOfWeek(weatherArr: [Weather]) {
        
        for weather in weatherArr {
            let stringDate = weather.date
            let weatherDate = stringToDate(dateString: stringDate)
            let dayNumber = weatherDate.ow_numberOfWeekDay()
            weather.weekDay = getDayString(number: dayNumber ?? 0)
        }
    }
    
    func getDayString(number: Int) -> String {
        let dayOfWeek: String
        switch number {
        case 1:
            dayOfWeek = "sunday"
        case 2:
            dayOfWeek = "monday"
        case 3:
            dayOfWeek = "tuesday"
        case 4:
            dayOfWeek = "wednesday"
        case 5:
            dayOfWeek = "thursday"
        case 6:
            dayOfWeek = "friday"
        case 7:
            dayOfWeek = "saturday"
        default:
            dayOfWeek = ""
        }
        return dayOfWeek
    }
    
    static func getTimeFromUNIXTime(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func getTimeFromUNIXInt(date: Int) -> Int? {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH"
        let intTime = Int(dateFormatter.string(from: date))
        return intTime
    }
    
    func correctTime(time: Int) -> Int {
        var tempTime = time
        if time < 0 {
             tempTime += 24
         } else if time > 24 {
             tempTime -= 24
         }
        return tempTime
    }
    
    func stringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    func configureTableCell(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)//#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
}
