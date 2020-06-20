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
}

class WeatherRouterImpl: WeatherRouter {
    
    weak var view: WeatherViewController!
    
    init(view: WeatherViewController) {
        self.view = view
    }

    func openSearchCityVC() {
        let storyBoard = UIStoryboard(name: "SearchCityViewController", bundle: nil)
        if #available(iOS 13.0, *) {
            let controller = storyBoard.instantiateViewController(identifier: "SearchVC")
            self.view.present(controller, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}
