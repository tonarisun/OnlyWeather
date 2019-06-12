//
//  DayWeatherTableView.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 12/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class DayWeatherTableView: UITableView {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

}
