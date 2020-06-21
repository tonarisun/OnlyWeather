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
    
    //MARK: - Outlets & Data
    @IBOutlet weak var viewController: SearchCityViewController!
    weak var presenter: SearchCityPresenterImpl?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure(self.viewController)
    }
    
    //MARK: - Configure
    private func configure(_ controller: SearchCityViewController) {
        let router = SearchCityRouterImpl()
        let presenter = SearchCityPresenterImpl(view: controller,
                                                router: router,
                                                getCitiesUseCase: GetCitiesUseCaseImpl(),
                                                updateCurrentCityUseCase: UpdateCurrentCityUseCaseImpl(),
                                                updateUserCitiesUseCase: UpdateUserCitiesUseCaseImpl())
        router.view = controller
        self.presenter = presenter
        controller.presenter = presenter
        controller.configurator = self
    }
}
