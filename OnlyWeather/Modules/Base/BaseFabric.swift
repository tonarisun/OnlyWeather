//
//  BaseFabric.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class BaseFabric {
    
    //MARK: - Data
    weak var tableView: UITableView?
    
    //MARK: - Init
    init(with tableView: UITableView) {
        self.tableView = tableView
        self.registerCells()
    }
    
    //MARK: - Register Cells
    func registerCells() {
        
    }
    
    //MARK: - Cells
    func cell(for rowModel: RowModel, at indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
