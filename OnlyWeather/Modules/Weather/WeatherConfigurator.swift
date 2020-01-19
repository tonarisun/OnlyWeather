//
//  WeatherConfigurator.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

@objc protocol WeatherConfigurator {

    func configure(_ controller: WeatherViewController)
}

class WeatherConfiguratorImpl: NSObject, WeatherConfigurator {
    
    func configure(_ controller: WeatherViewController) {
        let router = WeatherRouterImpl(view: controller)
        
        controller.presenter = WeatherPresenterImpl(view: controller,
                                                    router: router,
                                                    getWeatherUseCase: GetWeatherUseCaseImpl(),
                                                    getTodayWeatherUseCase: GetTodayWeatherUseCaseImpl())
    }
    
}
