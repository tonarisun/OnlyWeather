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
    
    func getWeather(cityID: String, completion: @escaping ([Weather]) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c").responseObject { (response: DataResponse<WeatherResponse>) in
            guard let weatherResponse = response.result.value else { return }
            let weathers = weatherResponse.response
            completion(weathers)
        }
    }
    
    func getTodayWeather(cityID: String, completion: @escaping (TodayWeather) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?id=\(cityID)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c").responseObject { (response: DataResponse<TodayWeather>) in
            guard let todayWeather = response.result.value else { return }
            completion(todayWeather)
        }
    }
    
    func getDayAndTime(weatherList: [Weather], timezone: Int) {
        for weatherItem in weatherList {
            var charArray = Array(weatherItem.date)
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
    }
    
    func sortWeatherByDay(weatherList: [Weather]) -> [Weather] {
        var weatherByDay = [Weather]()
        guard let time = weatherList.first?.time else {
            return weatherByDay
        }
        if time > 7 && time < 23 {
            for weather in weatherList {
                if (weather.time >= 13 && weather.time <= 15) || (weather.time >= 1 && weather.time <= 3) {
                    weatherByDay.append(weather)
                }
            }
            if weatherByDay.first!.time >= 13 && weatherByDay.first!.time <= 15 {
                weatherByDay.removeFirst()
            }
        } else {
            for weather in weatherList {
                if (weather.time >= 13 && weather.time <= 15) || (weather.time >= 1 && weather.time <= 3) {
                    weatherByDay.append(weather)
                }
            }
            if weatherByDay.first!.time >= 1 && weatherByDay.first!.time <= 3 {
                weatherByDay.removeFirst()
            }
        }
        return weatherByDay
    }
    
    func getDaysOfWeek(weatherArr: [Weather]) {
        for weather in weatherArr {
            let stringDate = weather.date
            let weatherDate = stringToDate(dateString: stringDate)
            let dayNumber = weatherDate.numberOfWeekDay()
            weather.weekDay = getDayString(number: dayNumber)
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
    
    public func getTimeFromUNIXTime(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}

extension Date {
    
    public func hour() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(in: .current, from: self)
        let hour = components.hour
        return hour!
    }
    
    public func date() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(in: .current, from: self)
        let date = components.day
        return date!
    }
    
    func numberOfWeekDay() -> Int {
        let day = Calendar.current.dateComponents([.weekday], from: self as Date).weekday
        return day!
    }
}

