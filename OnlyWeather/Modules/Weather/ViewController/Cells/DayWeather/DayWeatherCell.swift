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
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var skyDescriptionLabel: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subView.configureShadow()
    }
    
    //MARK: - Construct
    func construct(with model: DayWeatherRowModel, row: Int) -> DayWeatherCell {
        let weekDay = model.weekDay.localized()
        if model.time > 21 || model.time < 6 {
            self.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageNight(skyDescription: model.sky)
            if row == 0 {
                let text = "today_night".localized()
                self.dateLabel.attributedText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            } else {
                self.dateLabel.attributedText = nil
            }
        } else {
            self.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageDay(skyDescription: model.sky)
            if row == 0 {
                let text = "today".localized()
                self.dateLabel.attributedText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            } else {
                self.dateLabel.attributedText = NSAttributedString(string: weekDay + ", \(model.day).\(model.month)", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            }
        }
        self.humidityLabel.text  = "\(model.humidity) %"
        self.pressureLabel.text  = "\(model.pressure) " + "mm".localized()
        self.tempLabel.text      = "\(model.temp) °С"
        self.windSpeedLabel.text = "\(model.windSpeed) " + "m/s".localized()
        self.windDirectionImageView.image = SkyImageHelper.setWindDirectionImage(degree: model.windDirection)
        self.skyDescriptionLabel.text = model.description.localized()
        return self
    }
}
