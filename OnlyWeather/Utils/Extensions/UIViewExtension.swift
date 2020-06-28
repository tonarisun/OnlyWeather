//
//  UIView Extension.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

extension UIView {
    
    func configureShadow(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3.5
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
    static func ow_identifier() -> String {
        return String(describing: self)
    }
    
    static func ow_nib() -> UINib {
        return UINib(nibName: self.ow_identifier(), bundle: Bundle(for: self))
    }
}
