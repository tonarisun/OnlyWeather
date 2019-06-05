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
    
    func getTodayWeather(cityID: String, completion: @escaping ([Weather]) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c").responseObject { (response: DataResponse<WeatherResponse>) in
            guard let weatherResponse = response.result.value else { return }
            let weathers = weatherResponse.response
            completion(weathers)
        }
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

