//
//  SearchCityConfigurator.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

@objc protocol SearchCityConfigurator {
    
    func configure(_ controller: SearchCityViewController)
}

class SearchCityConfiguratorImpl: NSObject, SearchCityConfigurator {
    
    func configure(_ controller: SearchCityViewController) {
        let router = SearchCityRouterImpl(view: controller)
        
        controller.presenter = SearchCityPresenterImpl(view: controller,
                                                       router: router,
                                                       getCitiesUseCase: GetCitiesUseCaseImpl())
    }
}
