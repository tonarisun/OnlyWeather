//
//  Extensions.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 27.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func ow_register<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(T.self.ow_nib(), forCellReuseIdentifier: T.self.ow_identifier())
    }
    
    func ow_dequeueReusablweCell<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: T.self.ow_identifier(), for: indexPath) as? T
    }
}
