//
//  SearchCityConfigurator.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

@objc protocol SearchCityConfigurator {
}

class SearchCityConfiguratorImpl: NSObject, SearchCityConfigurator {
    
    @IBOutlet weak var viewController: SearchCityViewController!
    weak var presenter: SearchCityPresenterImpl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure(self.viewController)
    }
    
    private func configure(_ controller: SearchCityViewController) {
        let router = SearchCityRouterImpl()
        let presenter = SearchCityPresenterImpl(view: controller,
                                                router: router,
                                                getCitiesUseCase: GetCitiesUseCaseImpl())
        router.view = controller
        self.presenter = presenter
        controller.presenter = presenter
        controller.configurator = self
    }
}
