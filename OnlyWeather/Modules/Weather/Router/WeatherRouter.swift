//
//  WeatherRouter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherRouter: class {
    
    func openSearchCityVC()
    func openMyCitiesVC()
}

class WeatherRouterImpl: WeatherRouter {
    
    //MARK: - Data
    weak var view: WeatherViewController!
    
    //MARK: - Init
    init(view: WeatherViewController) {
        self.view = view
    }

    //MARK: - Open Controllers
    func openSearchCityVC() {
        let storyBoard = UIStoryboard(name: "SearchCityViewController", bundle: nil)
        if #available(iOS 13.0, *) {
            let controller = storyBoard.instantiateViewController(identifier: "SearchVC")
            self.view.present(controller, animated: true, completion: nil)
        } else {
        }
    }
    
    func openMyCitiesVC() {
        let storyBoard = UIStoryboard(name: "CitiesListViewController", bundle: nil)
        if #available(iOS 13.0, *) {
            let controller = storyBoard.instantiateViewController(identifier: "MyCitiesVC")
            self.view.present(controller, animated: true, completion: nil)
        } else {
        }
    }
}
