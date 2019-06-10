//
//  TopMenuButton.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 10/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.layer.borderWidth = 1
    }
}
