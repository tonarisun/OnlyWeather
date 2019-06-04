//
//  SearchCityCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class SearchCityCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var addCityButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addCityButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
    }
    
    @IBAction func addCity(_ sender: Any) {
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
        addCityButton.backgroundImage(for: .normal)
    }
}
