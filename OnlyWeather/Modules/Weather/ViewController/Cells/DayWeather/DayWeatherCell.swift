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
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var skyImageView: UIImageView!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Construct
    func construct(with model: DayWeatherRowModel) -> DayWeatherCell {
        
        let day = CurrentCityTime.instance.day
        let night = CurrentCityTime.instance.night
        
        if model.time > night || model.time <= day {
            self.dayLabel.textColor = #colorLiteral(red: 0.231992662, green: 0.2306199968, blue: 0.2330519557, alpha: 0.7485819777)
            self.tempLabel.textColor = #colorLiteral(red: 0.231992662, green: 0.2306199968, blue: 0.2330519557, alpha: 0.7485819777)
            self.skyImageView.image = SkyImageHelper.setSkyImageNight(skyDescription: model.sky)
        } else {
            self.dayLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.tempLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageDay(skyDescription: model.sky)
        }
        
        self.dayLabel.text = model.weekDay
        self.tempLabel.text = model.temp + "°"

        return self
    }
}
