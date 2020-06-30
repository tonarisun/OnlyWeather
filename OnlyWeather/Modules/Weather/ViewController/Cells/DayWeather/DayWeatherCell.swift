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
    @IBOutlet weak var tempLabelDay: UILabel!
    @IBOutlet weak var skyImageViewDay: UIImageView!
    @IBOutlet weak var tempLabelNight: UILabel!
    @IBOutlet weak var skyImageViewNight: UIImageView!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Construct
    func construct(with model: DayWeatherRowModel) -> DayWeatherCell {
        
        self.dayLabel.text = model.weekDay
        
        self.tempLabelDay.text = "\(model.tempDay ?? "")°"
        self.skyImageViewDay.image = SkyImageHelper.setSkyImageDay(skyDescription: model.skyDay ?? "")

        self.tempLabelNight.text = "\(model.tempNight ?? "")°"
        self.skyImageViewNight.image = SkyImageHelper.setSkyImageNight(skyDescription: model.skyNight ?? "")
        
        return self
    }
}
