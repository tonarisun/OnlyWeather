//
//  NEWHoursWeatherTableCell.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 28.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class NEWHoursWeatherTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var tutorialMessageLabel: UILabel!
    
    var fabric: NEWHoursWeatherCellFabric?
    var model: NEWHoursWeatherTableRowModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initFabric()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.dateView.configureShadow(radius: 15)
        self.dateView.backgroundColor = #colorLiteral(red: 0.3142627478, green: 0.5710065961, blue: 0.6863108873, alpha: 1)
        
        self.tutorialView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideTutorial))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(hideTutorial))
        swipe.direction = .left
        self.tutorialView.addGestureRecognizer(swipe)
        self.tutorialView.addGestureRecognizer(tap)
    }
    
    private func initFabric() {
        self.fabric = NEWHoursWeatherCellFabric(collectionView: self.collectionView)
    }
    
    func construct(with model: NEWHoursWeatherTableRowModel) -> NEWHoursWeatherTableCell {
        self.showTutorial()
        self.model = model
        self.collectionView.reloadData()
        return self
    }
    
    private func showTutorial() {
        if !UserDefaults.standard.bool(forKey: "tutorial_viewed") {
            self.tutorialMessageLabel.text = "tutorial_message".localized()
            self.tutorialView.isHidden = false
            UserDefaults.standard.set(true, forKey: "tutorial_viewed")
        }
    }
    
    @objc func hideTutorial() {
        self.tutorialView.isHidden = true
    }
}

extension NEWHoursWeatherTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.model?.sections.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model?.sections[section].rows.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = self.model?.sections[indexPath.section].rows[indexPath.row] {
            return self.fabric?.cell(for: model, at: indexPath, scrollDelegate: self) ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let model = self.model?.sections[indexPath.section].rows[indexPath.row] as? NEWHourWeatherRowModel {
            self.dateLabel.text = model.weekDay + ", " + model.date
        }
    }
}

extension NEWHoursWeatherTableCell: ScrollDelegate {
    
    func scrollToTop() {
        self.collectionView.setContentOffset(.zero, animated: true)
    }
}
