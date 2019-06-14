//
//  TodayWeatherCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 08/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class TodayWeatherCell: UITableViewCell {
    
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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        subView.layer.cornerRadius = 20
        subView.layer.shadowOpacity = 1
        subView.layer.shadowOffset = .zero
        subView.layer.shadowColor = #colorLiteral(red: 0.03500115871, green: 0.06159752607, blue: 0.07407174259, alpha: 1)
        
    }
}
