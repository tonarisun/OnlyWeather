//
//  UICollectionViewExtension.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func ow_register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(T.self.ow_nib(), forCellWithReuseIdentifier: T.self.ow_identifier())
    }
    
    func ow_dequeueReusablweCell<T: UICollectionViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: T.self.ow_identifier(), for: indexPath) as? T
    }
}
