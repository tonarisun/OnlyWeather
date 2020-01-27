//
//  HourWeatherCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 06/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var skyLabel: UILabel!
    
    //MARK: - Data
    let helper = SkyImageHelper()
    
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
//        self.layer.masksToBounds = false
        self.layer.cornerRadius = 14
        self.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        
        skyImageView.clipsToBounds = true
        skyImageView.layer.cornerRadius = 14
    }
    
    //MARK: - Construct
    func construct(with weather: Weather) {
        self.dateLabel.text = "\(weather.time):00"
        let temp = Int(weather.temp)
        self.tempLabel.text = "\(temp) °C"
        self.skyLabel.text = weather.skyDescription.localized()
    }    
}
