//
//  Date Extension.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

extension Date {
    
    public func ow_hour() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(in: .current, from: self)
        let hour = components.hour
        return hour!
    }
    
    public func ow_date() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(in: .current, from: self)
        let date = components.day
        return date!
    }
    
    func ow_numberOfWeekDay() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self as Date).weekday
    }
}
