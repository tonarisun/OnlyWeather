//
//  NEWHoursWeatherCellFabric.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 28.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class NEWHoursWeatherCellFabric {
    
    weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.registerCell()
    }
    
    private func registerCell() {
        self.collectionView?.ow_register(NEWHourWeatherCollectionCell.self)
    }
    
    func cell(for rowModel: RowModel, at indexPath: IndexPath, scrollDelegate: ScrollDelegate) -> UICollectionViewCell {
        
        if let model = rowModel as? NEWHourWeatherRowModel,
            let cell = self.collectionView?.ow_dequeueReusablweCell(NEWHourWeatherCollectionCell.self, indexPath: indexPath) {
            cell.scrollDelegate = scrollDelegate
            return cell.construct(with: model)
        }
        
        return UICollectionViewCell()
    }
}
