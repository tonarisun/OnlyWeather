//
//  DayWeatherCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 06/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureImageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var skyDescriptionLabel: UILabel!
    
    //MARK: - Data
    let helper = SkyImageHelper()
    
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subView.configureShadow()
    }
    
    //MARK: - Construct
    func construct(with weather: Weather, row: Int) -> DayWeatherCell {
        let weekDay = weather.weekDay.localized()
        if weather.time > 21 || weather.time < 6 {
            self.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
            helper.setSkyImageNight(skyDescription: weather.sky, imageView: self.skyImageView)
            if row == 1 {
                let text = "today_night".localized()
                self.dateLabel.attributedText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            } else {
                self.dateLabel.attributedText = nil
            }
        } else {
            self.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
            helper.setSkyImageDay(skyDescription: weather.sky, imageView: self.skyImageView)
            if row == 1 {
                let text = "today".localized()
                self.dateLabel.attributedText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            } else {
                self.dateLabel.attributedText = NSAttributedString(string: weekDay + ", \(weather.day).\(weather.month)", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            }
        }
        self.humidityLabel.text = "\(weather.humidity) %"
        let pressure = Int(weather.pressure / 1.333)
        self.pressureLabel.text = "\(pressure) " + "mm".localized()
        let temp = NSString(format:"%.1f", weather.temp)
        self.tempLabel.text = "\(temp) °С"
        let windSpeed = Int(weather.windSpeed)
        self.windSpeedLabel.text = "\(windSpeed) " + "m/s".localized()
        helper.setWindDirectionImage(degree: weather.windDeg, imageView: self.windDirectionImageView)
        self.skyDescriptionLabel.text = weather.skyDescription.localized()
        return self
    }
}
