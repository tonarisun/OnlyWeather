//
//  CitiesListPresenter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol CitiesListPresenter: class {

    init(view: CitiesListView,
         router: CitiesListRouter,
         getCitiesUseCase: GetUserCitiesUseCase,
         updateCurrentCityUseCase: UpdateCurrentCityUseCase,
         deleteUserCityUseCase: DeleteUserCityUseCase)
    
    func viewDidLoad()
    
    func cityTapped(with id: String)
    func deleteCityFromUserCities(with id: String)
}

class CitiesListPresenterImpl: CitiesListPresenter {
    
    //MARK: - VUPER
    var view: CitiesListView?
    var router: CitiesListRouter?
    var getCitiesUseCase: GetUserCitiesUseCase?
    var updateCurrentCityUseCase: UpdateCurrentCityUseCase?
    var deleteUserCityUseCase: DeleteUserCityUseCase?
    
    //MARK: - Data
    var cities = [City]()
    
    //MARK: - Init
    required init(view: CitiesListView,
                  router: CitiesListRouter,
                  getCitiesUseCase: GetUserCitiesUseCase,
                  updateCurrentCityUseCase: UpdateCurrentCityUseCase,
                  deleteUserCityUseCase: DeleteUserCityUseCase) {
        self.view = view
        self.router = router
        self.getCitiesUseCase = getCitiesUseCase
        self.updateCurrentCityUseCase = updateCurrentCityUseCase
        self.deleteUserCityUseCase = deleteUserCityUseCase
    }
    
    //MARK: - Life Cycle
    func viewDidLoad() {
        self.loadUserCities()
    }
    
    //MARK: - Load Data
    func loadUserCities() {
        self.getCitiesUseCase?.execute(completion: { (cities) in
            self.cities = cities
            self.view?.show(cities: self.cities)
        })
    }
    
    //MARK: - Actions
    func cityTapped(with id: String) {
        if let city = self.cities.first(where: { (city) in
            city.cityID == id
            }) {
            self.updateCurrentCityUseCase?.execute(city: city, completion: { (success) in
                router?.hideViewController()
            })
        }
    }
    
    func deleteCityFromUserCities(with id: String) {
        self.deleteUserCityUseCase?.execute(cityID: id, completion: { (success) in
            self.loadUserCities()
        })
    }
}
