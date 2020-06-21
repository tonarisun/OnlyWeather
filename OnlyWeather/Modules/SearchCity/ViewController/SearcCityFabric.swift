//
//  SearcCityFabric.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 20.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class SearcCityFabric: BaseFabric {
    
    
    weak var delegate: CitySearchDelegate?
    
    init(tableView: UITableView, delegate: CitySearchDelegate) {
        self.delegate = delegate
        super.init(with: tableView)
    }
    
    override func registerCells() {
        self.tableView?.ow_register(SearchCityCell.self)
    }
    
    override func cell(for rowModel: RowModel, at indexPath: IndexPath) -> UITableViewCell {
        
        if let cityMdel = rowModel as? SearchCityRowModel,
            let cell = self.tableView?.ow_dequeueReusablweCell(SearchCityCell.self, indexPath: indexPath) {
            return cell.construct(with: cityMdel, delegate: self.delegate)
        }
        
        return UITableViewCell()
    }
}
