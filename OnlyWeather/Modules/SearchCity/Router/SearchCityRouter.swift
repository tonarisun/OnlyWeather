//
//  SearchCityRouter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol SearchCityRouter: class {

    func hideViewController()
}

class SearchCityRouterImpl: SearchCityRouter {
    
    weak var view: SearchCityViewController!
    
    init(view: SearchCityViewController) {
        self.view = view
    }
    
    func hideViewController() {
        view.dismiss(animated: true)
    }
}
