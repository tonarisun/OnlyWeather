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
    
    @IBOutlet weak var viewController: CitiesListViewController!
    weak var presenter: CitiesListPresenterImpl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure(self.viewController)
    }
    
    private func configure(_ controller: CitiesListViewController) {
        let router = CitiesListRouterImpl()
        let presenter = CitiesListPresenterImpl(view: controller,
                                                router: router,
                                                getCitiesUseCase: GetUserCitiesUseCaseImpl())
        
        router.view = controller
        self.presenter = presenter
        controller.presenter = presenter
        controller.configurator = self
    }
}
