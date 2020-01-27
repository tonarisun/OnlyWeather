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
    
    //MARK: - Data
    let helper = SkyImageHelper()

    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let now = "Now".localized()
        nowLabel.attributedText = NSAttributedString(string: now, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        self.subView.configureShadow()
    }
    
    //MARK: - Construct
    func construct(with weather: TodayWeather) -> TodayWeatherCell {
        if weather.time > weather.sunrise && weather.time < weather.sunset {
            helper.setSkyImageDay(skyDescription: weather.sky, imageView: self.skyImageView)
            self.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
        } else {
            helper.setSkyImageNight(skyDescription: weather.sky, imageView: self.skyImageView)
            self.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
        }
        let temp = NSString(format:"%.1f", weather.temp)
        self.tempLabel.text = "\(temp) °"
        let pressure = Int(weather.pressure / 1.333)
        self.pressureLabel.text = "\(pressure) " + "mm".localized()
        self.humidityLabel.text = "\(weather.humidity) %"
        let windSpeed = Int(weather.windSpeed)
        self.windSpeedLabel.text = "\(windSpeed) " + "m/s".localized()
        helper.setWindDirectionImage(degree: weather.windDeg, imageView: self.windDirectionImageView)
        self.skyDescriptionLabel.text = weather.skyDescription.localized()
        let sunrise = weather.sunrise + weather.timezone
        let sunset = weather.sunset + weather.timezone
        self.sunriseLabel.text = Service.getTimeFromUNIXTime(date: (Double(sunrise)))
        self.sunsetLabel.text = Service.getTimeFromUNIXTime(date: (Double(sunset)))
        return self
    }
}
