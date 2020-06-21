//
//  UIButtonExtension.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

extension UIButton {
    
    func springAnimate() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.7
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 2
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}
