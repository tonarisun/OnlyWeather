//
//  SearchCityCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

protocol CitySearchDelegate: class {
    
    func addButtonTapped(with model: SearchCityRowModel?)
}

class SearchCityCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var addCityButton: UIButton!

    //MARK: - Data
    var model: SearchCityRowModel?
    weak var delegate: CitySearchDelegate?
    
    //MARK: - Configure
    func construct(with model: SearchCityRowModel, delegate: CitySearchDelegate?) -> SearchCityCell {
        self.model = model
        self.delegate = delegate
        self.cityNameLabel.text = model.cityName
        self.addCityButton.isHidden = model.inMyCities
        return self
    }
    
    //MARK: - Add button
    @IBAction func addCity(_ sender: Any) {
        self.delegate?.addButtonTapped(with: self.model)
        self.addCityButton.springAnimate()
    }

    override func prepareForReuse() {
        cityNameLabel.text = nil
    }
}
