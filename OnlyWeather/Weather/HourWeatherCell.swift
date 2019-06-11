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
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowColor = #colorLiteral(red: 0.06706253439, green: 0.1177868322, blue: 0.1453602314, alpha: 1)
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        
        skyImageView.clipsToBounds = true
        skyImageView.layer.cornerRadius = 8
        skyImageView.layer.borderColor = #colorLiteral(red: 0.1030835286, green: 0.1839706004, blue: 0.2240745425, alpha: 1)
        skyImageView.layer.borderWidth = 1
    }
    
}
