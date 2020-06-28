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
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var skyDescriptionLabel: UILabel!
    
    @IBOutlet weak var dateViewTempSpacing: NSLayoutConstraint!
    @IBOutlet weak var dateViewHeight: NSLayoutConstraint!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subView.configureShadow(radius: 25)
        self.dateView.configureShadow(radius: 15)
    }
    
    //MARK: - Construct
    func construct(with model: DayWeatherRowModel, row: Int) -> DayWeatherCell {
        let weekDay = model.weekDay.localized()
        if model.time > 21 || model.time < 6 {
            self.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
            self.dateView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageNight(skyDescription: model.sky)
            if row == 0 {
                self.hideDateView(false)
                self.dateLabel.text = "today_night".localized()
            } else {
                self.hideDateView(true)
                self.dateLabel.attributedText = nil
            }
        } else {
            self.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
            self.dateView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageDay(skyDescription: model.sky)
            if row == 0 {
                self.hideDateView(false)
                self.dateLabel.text = "today".localized()
            } else {
                self.hideDateView(false)
                self.dateLabel.text = weekDay + ", \(model.day).\(model.month)"
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
    
    private func hideDateView(_ hide: Bool) {
        self.dateView.isHidden = hide
        self.dateViewHeight.constant = hide ? 0 : 40
        self.dateViewTempSpacing.constant = hide ? 0 : 16
        self.layoutIfNeeded()
    }
}
