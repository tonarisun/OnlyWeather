//
//  HoursWeatherTableCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class HoursWeatherTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fabric: HoursWeatherCellFabric?
    var model: HoursWeatherTableRowModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initFabric()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset.left = 7
    }
    
    private func initFabric() {
        self.fabric = HoursWeatherCellFabric(collectionView: self.collectionView)
    }
    
    func construct(with model: HoursWeatherTableRowModel) -> HoursWeatherTableCell {
        self.model = model
        self.collectionView.reloadData()
        return self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.model?.sections.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model?.sections[section].rows.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = self.model?.sections[indexPath.section].rows[indexPath.row] {
            return self.fabric?.cell(for: model, at: indexPath, day: self.model?.day ?? 7, night: self.model?.night ?? 22) ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}
