//
//  BaseFabric.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class BaseFabric {
    
    weak var tableView: UITableView?
    
    init(with tableView: UITableView) {
        self.tableView = tableView
        self.registerCells()
    }
    
    func registerCells() {
        
    }
    
    func cell(for rowModel: RowModel, at indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
