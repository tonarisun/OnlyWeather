//
//  TodayWeatherCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 08/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class TodayWeatherCell: UITableViewCell {
    
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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let now = NSLocalizedString("Now", comment: "")
        nowLabel.attributedText = NSAttributedString(string: now, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        subView.layer.cornerRadius = 20
        subView.layer.shadowOpacity = 0.5
        subView.layer.shadowOffset = .zero
        subView.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
    }
}
