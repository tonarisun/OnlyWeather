//
//  CitiesListConfigurator.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

@objc protocol CitiesListConfigurator: class {
}

class CitiesListConfiguratorImpl: NSObject, CitiesListConfigurator {
    
    //MARK: - Outlets & Data
    @IBOutlet weak var viewController: CitiesListViewController!
    weak var presenter: CitiesListPresenterImpl?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure(self.viewController)
    }
    
    //MARK: - Configure
    private func configure(_ controller: CitiesListViewController) {
        let router = CitiesListRouterImpl()
        let presenter = CitiesListPresenterImpl(view: controller,
                                                router: router,
                                                getCitiesUseCase: GetUserCitiesUseCaseImpl(),
                                                updateCurrentCityUseCase: UpdateCurrentCityUseCaseImpl(),
                                                deleteUserCityUseCase: DeleteUserCityUseCaseImpl())
        
        router.view = controller
        self.presenter = presenter
        controller.presenter = presenter
        controller.configurator = self
    }
}
