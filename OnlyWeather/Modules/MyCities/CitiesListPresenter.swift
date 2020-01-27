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
         router: CitiesListRouter)
    func loadCitiesFromRLM() -> Results<City>?
    func updateCurrentCity(city: City, currentCity: CurrentCity)
    func cityTapped()
    func deleteCityFromRealm(_ city: City)
}

class CitiesListPresenterImpl: CitiesListPresenter {
    
    //MARK: - VUPER
    var view: CitiesListView?
    var router: CitiesListRouter?
    
    //MARK: - Data
    var cities : Results<City>?
    let rlmHelper = RealmHelper()
    
    //MARK: - Init
    required init(view: CitiesListView,
                  router: CitiesListRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Presenter protocol
    func updateCurrentCity(city: City, currentCity: CurrentCity) {
        rlmHelper.updateCurrentCity(city: city, currentCity: currentCity)
    }
    
    func loadCitiesFromRLM() -> Results<City>? {
        do {
            let realm = try Realm()
            self.cities = realm.objects(City.self)
        } catch {
            print(error)
        }
        return self.cities ?? nil
    }
    
    func cityTapped() {
        router?.hideViewController()
    }
    
    func deleteCityFromRealm(_ city: City) {
        rlmHelper.deleteCity(city)
    }
}
