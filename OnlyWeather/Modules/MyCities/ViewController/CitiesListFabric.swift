//
//  CitiesListFabric.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class CitiesListFabric: BaseFabric {
    
    override func registerCells() {
        self.tableView?.ow_register(CityCell.self)
    }
    
    override func cell(for rowModel: RowModel, at indexPath: IndexPath) -> UITableViewCell {
        
        if let cityModel = rowModel as? CityRowModel,
            let cell = self.tableView?.ow_dequeueReusablweCell(CityCell.self, indexPath: indexPath) {
            return cell.construct(with: cityModel)
        }
        
        return UITableViewCell()
    }
}
