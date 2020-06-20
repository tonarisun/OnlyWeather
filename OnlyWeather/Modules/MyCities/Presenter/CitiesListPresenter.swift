//
//  CitiesListPresenter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import RealmSwift

protocol CitiesListPresenter: class {

    init(view: CitiesListView,
         router: CitiesListRouter,
         getCitiesUseCase: GetUserCitiesUseCase)
    
    func viewDidLoad()
    
    func cityTapped(with id: String)
    func deleteCityFromRealm(with id: String)
}

class CitiesListPresenterImpl: CitiesListPresenter {
    
    //MARK: - VUPER
    var view: CitiesListView?
    var router: CitiesListRouter?
    var getCitiesUseCase: GetUserCitiesUseCase?
    
    //MARK: - Data
    var cities = [City]()
    let rlmHelper = RealmHelper()
    
    //MARK: - Init
    required init(view: CitiesListView,
                  router: CitiesListRouter,
                  getCitiesUseCase: GetUserCitiesUseCase) {
        self.view = view
        self.router = router
        self.getCitiesUseCase = getCitiesUseCase
    }
    
    //MARK: - Life Cycle
    func viewDidLoad() {
        self.loadCitiesFromRLM()
    }
    
    //MARK: - Load Data
    func loadCitiesFromRLM() {
        self.getCitiesUseCase?.execute(completion: { (cities) in
            self.cities = cities
            self.view?.show(cities: self.cities)
        })
    }
    
    //MARK: - Actons
    func cityTapped(with id: String) {
        self.updateCurrentCity(with: id)
        router?.hideViewController()
    }
    
    func deleteCityFromRealm(with id: String) {
        var cities = [City]()
        self.cities.enumerated().forEach { (index, item) in
            if item.cityID == id {
                self.rlmHelper.deleteCity(with: id)
            } else {
                cities.append(item)
            }
        }
        self.cities = cities
        self.view?.show(cities: self.cities)
    }
    
    //MARK: - Private methods
    private func updateCurrentCity(with id: String) {
        if let city = self.cities.first(where: { (city) in
            city.cityID == id
            }) {
            rlmHelper.updateCurrentCity(city: city)
        }
    }
}
