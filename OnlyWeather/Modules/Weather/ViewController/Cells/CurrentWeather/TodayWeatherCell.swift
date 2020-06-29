//
//  TodayWeatherCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 08/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class TodayWeatherCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var nowView: UIView!
    @IBOutlet weak var nowLabel: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var skyDescriptionLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
        
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nowLabel.text = "Now".localized()
        self.subView.configureShadow(radius: 25.0)
        self.nowView.configureShadow(radius: 15)
        self.nowView.backgroundColor = #colorLiteral(red: 0.3142627478, green: 0.5710065961, blue: 0.6863108873, alpha: 1)
    }
    
    //MARK: - Construct
    func construct(with model: TodayWeatherRowModel) -> TodayWeatherCell {
        if model.timeInt > model.sunriseInt, model.timeInt < model.sunsetInt {
            self.skyImageView.image = SkyImageHelper.setSkyImageDay(skyDescription: model.sky)
            self.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
        } else {
            self.skyImageView.image = SkyImageHelper.setSkyImageNight(skyDescription: model.sky)
            self.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
        }

        self.tempLabel.text = "\(model.temp) °"
        self.pressureLabel.text = "\(model.pressure) " + "mm".localized()
        self.humidityLabel.text = "\(model.humidity) %"
        self.windSpeedLabel.text = "\(model.windSpeed) " + "m/s".localized()
        self.windDirectionImageView.image = SkyImageHelper.setWindDirectionImage(degree: model.windDirection)
        self.skyDescriptionLabel.text = model.description.localized()
        self.sunriseLabel.text = model.sunrise
        self.sunsetLabel.text = model.sunset
        return self
    }
}
