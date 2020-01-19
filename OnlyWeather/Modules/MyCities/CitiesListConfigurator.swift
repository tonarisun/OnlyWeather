//
//  CitiesListConfigurator.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

@objc protocol CitiesListConfigurator: class {

    func configure(_ controller: CitiesListViewController)
}

class CitiesListConfiguratorImpl: CitiesListConfigurator {
    
    func configure(_ controller: CitiesListViewController) {
        
        let router = CitiesListRouterImpl(view: controller)
        
        controller.presenter = CitiesListPresenterImpl(view: controller, router: router)
    }
    
    
    
}
