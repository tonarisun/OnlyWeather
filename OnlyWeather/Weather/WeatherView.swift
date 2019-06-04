//
//  WeatherView.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import UIKit

class WeatherView : UIView {
    
    @IBOutlet weak var tempLabel : UILabel!
    @IBOutlet weak var minTempLabel : UILabel!
    @IBOutlet weak var maxTempLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var pressureLabel : UILabel!
    @IBOutlet weak var windSpeedLabel : UILabel!
    @IBOutlet weak var windDirectLabel : UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
