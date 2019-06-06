//
//  HourWeatherCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 06/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var skyImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var skyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderColor = #colorLiteral(red: 0.1641685963, green: 0.2979443967, blue: 0.3582572341, alpha: 1)
        self.contentView.layer.borderWidth = 1
        
        self.skyImageView.layer.cornerRadius = 8
        
    }
    
}
