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
    
    func dateToShort(string: String) -> String {
        var charArray = Array(string)
        for _ in 0...4 {
            charArray.removeFirst()
        }
        for _ in 0...2 {
            charArray.removeLast()
        }
        let newString = String(charArray)
        return newString
    }
    
    func getDayAndTame(weatherItem: Weather, string: String) {
        var charArray = Array(string)
        let dayArr = [charArray[5], charArray[6], charArray[7], charArray[8], charArray[9]]
        let timeArr = [charArray[11], charArray[12]]
        weatherItem.day = String(dayArr)
        weatherItem.time = String(timeArr)
    }
    
    func sortWeatherByDay(weatherList: [Weather]) -> [Weather] {
        var weatherList = weatherList
        var today = [Weather]()
        var weatherByDay = [Weather]()
        var i = 1
        for weather in weatherList {
            getDayAndTame(weatherItem: weather, string: weather.date)
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
        print(today)
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




//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>"),
//                  City(cityID: <#T##Int#>, cityName: "<#T##String#>", cityNameRUS: "<#T##String#>", country: "<#T##String#>")]

