//
//  SearchCityCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class SearchCityCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var addCityButton: UIButton!
    var city: City?
    let locale = NSLocale.preferredLanguages.first!
    
    //MARK: - Configure
    func configure(city: City) {
        self.city = city
        if locale.hasPrefix("ru") {
            cityNameLabel.text = city.cityNameRUS
        } else {
            cityNameLabel.text = city.cityName
        }
    }
    
    //MARK: - Add button 
    var addCityTapped : ((City) -> Void)?
    
    @IBAction func addCity(_ sender: Any) {
        addCityTapped?(city!)
        animatedButton()
    }
    
    func animatedButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.7
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 2
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.addCityButton.layer.add(animation, forKey: nil)
    }

    override func prepareForReuse() {
        cityNameLabel.text = nil
    }
}
