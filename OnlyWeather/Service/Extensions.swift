//
//  Extensions.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 27.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

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
    
    func numberOfWeekDay() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self as Date).weekday
    }
}

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIView {
    
    func configureShadow() {
        self.layer.cornerRadius = 25
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3.5
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
}
