//
//  NEWHourWeatherCollectionCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 28.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

protocol ScrollDelegate: class {
    
    func scrollToTop()
}

class NEWHourWeatherCollectionCell: UICollectionViewCell {
    
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
    
    //MARK: - Data
    var model: NEWHourWeatherRowModel?
    var scrollDelegate: ScrollDelegate?
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subView.configureShadow(radius: 25)
    }
    
    //MARK: - Construct
    func construct(with model: NEWHourWeatherRowModel) -> NEWHourWeatherCollectionCell {
        
        let taptap = UITapGestureRecognizer(target: self, action: #selector(scrollCollectionToTop))
        taptap.numberOfTapsRequired = 2
        self.subView.addGestureRecognizer(taptap)
        
        self.model = model
        
        if model.isDay {
            self.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageDay(skyDescription: model.sky)
        } else {
            self.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
            self.skyImageView.image = SkyImageHelper.setSkyImageNight(skyDescription: model.sky)
        }
        
        self.dateLabel.text = "\(model.time):00"
        
        self.humidityLabel.text  = "\(model.humidity) %"
        self.pressureLabel.text  = "\(model.pressure) " + "mm".localized()
        self.tempLabel.text      = "\(model.temp) °С"
        self.windSpeedLabel.text = "\(model.windSpeed) " + "m/s".localized()
        self.windDirectionImageView.image = SkyImageHelper.setWindDirectionImage(degree: model.windDirection)
        self.skyDescriptionLabel.text = model.description.localized()
        return self
    }
    
    @objc func scrollCollectionToTop() {
        self.scrollDelegate?.scrollToTop()
    }
}
