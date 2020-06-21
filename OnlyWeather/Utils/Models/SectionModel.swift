//
//  SectionModel.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class SectionModel {
    
    var id: String
    var rows = [RowModel]()
    
    init() {
        self.id = UUID().uuidString
    }
}
