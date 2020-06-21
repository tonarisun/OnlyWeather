//
//  HourWeatherCollectionCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class HourWeatherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
        self.layer.cornerRadius = 14
        self.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        
        skyImageView.clipsToBounds = true
        skyImageView.layer.cornerRadius = 14
    }

    func construct(with model: HourWeatherRowModel, day: Int, night: Int) -> HourWeatherCollectionCell {
        self.timeLabel.text = model.time
        self.tempLabel.text = "\(model.temp) °C"
        self.descriptionLabel.text = model.description.localized()
        
        SkyImageHelper.setSkyImage(model: model, cell: self, day: day, night: night)
        
        return self
    }
    
}
