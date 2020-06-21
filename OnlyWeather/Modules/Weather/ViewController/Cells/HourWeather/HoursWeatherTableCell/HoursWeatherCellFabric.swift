//
//  HoursWeatherCellFabric.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class HoursWeatherCellFabric {
    
    weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.registerCell()
    }
    
    private func registerCell() {
        self.collectionView?.ow_register(HourWeatherCollectionCell.self)
    }
    
    func cell(for rowModel: RowModel, at indexPath: IndexPath, day: Int, night: Int) -> UICollectionViewCell {
        
        if let model = rowModel as? HourWeatherRowModel,
            let cell = self.collectionView?.ow_dequeueReusablweCell(HourWeatherCollectionCell.self, indexPath: indexPath) {
            return cell.construct(with: model, day: day, night: night)
        }
        
        return UICollectionViewCell()
    }
}
