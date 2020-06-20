//
//  CitiesListRouter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol CitiesListRouter: class {

    func hideViewController()
}

class CitiesListRouterImpl: CitiesListRouter {
    
    weak var view: CitiesListViewController!

    func hideViewController() {
        view.dismiss(animated: true)
    }
}
