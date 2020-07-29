//
//  Date Extension.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

enum DateComponentType {
    
    case timeFull
    case weekDay
    case shortDate
    case hour
    
    var template: String {
        switch self {
        case .timeFull:
            return "HH:mm:ss"
        case .weekDay:
            return "EEEE"
        case .shortDate:
            return "dd.MM"
        case .hour:
            return "HH"
        }
    }
}

extension Date {
    
    static func getDateComponentFromUNIXTime(time: Int, type: DateComponentType) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = type.template
        return dateFormatter.string(from: date)
    }
    
    static func getTimeInt(date: Int) -> Int? {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH"
        let intTime = Int(dateFormatter.string(from: date))
        return intTime
    }
}
