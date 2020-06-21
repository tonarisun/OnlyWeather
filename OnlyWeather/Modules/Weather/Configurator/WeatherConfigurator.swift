//
//  WeatherConfigurator.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

@objc protocol WeatherConfigurator {

}

class WeatherConfiguratorImpl: NSObject, WeatherConfigurator {
    
    //MARK: - Outlets & Data
    @IBOutlet weak var viewController: WeatherViewController!
    weak var presenter: WeatherPresenterImpl?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        self.configure(viewController)
    }
    
    //MARK: - Configure
    private func configure(_ controller: WeatherViewController) {
        
        let router = WeatherRouterImpl(view: controller)
        let presenter = WeatherPresenterImpl(view: controller,
                                             router: router,
                                             getCurrentCityUseCase: GetCurrentCityUseCaseImpl(),
                                             getWeatherUseCase: GetWeatherUseCaseImpl(),
                                             getTodayWeatherUseCase: GetTodayWeatherUseCaseImpl())
        controller.presenter = presenter
        controller.configurator = self
        self.presenter = presenter
    }
}
