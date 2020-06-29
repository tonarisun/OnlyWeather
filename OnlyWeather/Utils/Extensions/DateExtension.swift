//
//  Date Extension.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

enum DateComponentType {
    
    case full
    case weekDay
    case shortDate
    case hour
    
    var template: String {
        switch self {
        case .full:
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
    
//    static func getTimeFull(date: Double) -> String {
//        let date = Date(timeIntervalSince1970: date)
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "HH:mm:ss"
//        return dateFormatter.string(from: date)
//    }
//    
//    static func getWeekDay(date: Int) -> String {
//        let date = Date(timeIntervalSince1970: TimeInterval(date))
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "EEEE"
//        return dateFormatter.string(from: date)
//    }
//    
//    static func getPrettyDate(date: Int) -> String {
//        let date = Date(timeIntervalSince1970: TimeInterval(date))
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "dd.MM"
//        return dateFormatter.string(from: date)
//    }
    
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
