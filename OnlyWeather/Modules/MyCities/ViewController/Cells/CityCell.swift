//
//  CityCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    func construct(with model: CityRowModel) -> CityCell {
        self.cityNameLabel.text = model.name
        return self
    }
}
