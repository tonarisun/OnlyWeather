//
//  RowModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class RowModel {
    
    var id: String
    
    init() {
        self.id = UUID().uuidString
    }
    
    required init(id: String) {
        self.id = id
    }
}
