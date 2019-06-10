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
    
    func getShortDateDayAndTime(weatherItem: Weather, string: String) {
        var charArray = Array(string)
        let shortDateArr = [charArray[8], charArray[9], ".", charArray[5], charArray[6], " ", charArray[11], charArray[12], charArray[13], charArray[14], charArray[15]]
        let dayArr = [charArray[8], charArray[9], ".", charArray[5], charArray[6]]
        let timeArr = [charArray[11], charArray[12]]
        weatherItem.shortDate = String(shortDateArr)
        weatherItem.day = String(dayArr)
        weatherItem.time = String(timeArr)
    }
   
    func sortWeatherByDay(weatherList: [Weather]) -> [Weather] {
        var weatherList = weatherList
        var today = [Weather]()
        var weatherByDay = [Weather]()
        var i = 1
        for weather in weatherList {
            getShortDateDayAndTime(weatherItem: weather, string: weather.date)
            if weather.day == weatherList[0].day {
                today.append(weather)
            }
        }
        for _ in 1...today.count {
            weatherList.removeFirst()
        }
        while i < weatherList.count {
            weatherByDay.append(weatherList[i])
            i += 4
        }
        return weatherByDay
    }
    
    public func getTimeFromUNIXTime(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

extension NSDate {
    func hour() -> Int {
        //Get Hour
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(in: .current, from: self as Date)
        let hour = components.hour
        //Return Hour
        return hour!
    }
}
