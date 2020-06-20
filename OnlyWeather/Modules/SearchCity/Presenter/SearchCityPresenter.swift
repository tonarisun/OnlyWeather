//
//  SearchCityPresenter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RealmSwift

protocol SearchCityPresenter: class {
    
    init(view: SearchCityView,
         router: SearchCityRouter,
         getCitiesUseCase: GetCitiesUseCase)
    
    func viewDidLoad()
    
    func onSelectCity(id: String?)
    func onTapAddButton(with cityID: String?)
    func filterCities(range: String)
}

class SearchCityPresenterImpl: SearchCityPresenter {
    
    //MARK: - VUPER
    var view: SearchCityView
    var router: SearchCityRouter
    
    //MARK: - UseCases
    var getCitiesUseCase: GetCitiesUseCase?
    
    //MARK: - Data
    let db = Firestore.firestore()
    let rlmHelper = RealmHelper()
    var data = SearchData()

    //MARK: - Init
    required init(view: SearchCityView,
                  router: SearchCityRouter,
                  getCitiesUseCase: GetCitiesUseCase) {
        self.view = view
        self.router = router
        self.getCitiesUseCase = getCitiesUseCase
    }
    
    //MARK: - Life Cycle
    func viewDidLoad() {
        self.getCities()
    }
    
    //MARK: - Load Data
    private func getCities() {
        getCitiesUseCase?.execute(completion: { (cities) in
            self.data.cities = cities ?? [City]()
            self.data.filteredCities = self.data.cities
            self.view.show(cities: self.data.cities)
        })
    }
    
    //MARK: - Presenter protocol
    func onSelectCity(id: String?) {
        if let selectedCity = self.data.cities.first(where: { (city) in
            city.cityID == id
        }) {
            self.updateCurrentCity(city: selectedCity)
            self.router.hideViewController()
        }
    }
    
    func onTapAddButton(with cityID: String?) {
        if let addedCity = self.data.cities.first(where: { (city) in
            city.cityID == cityID
        }) {
             self.updateMyCities(city: addedCity)
            self.view.addCityAlert(city: addedCity)
        }
    }
    
    func filterCities(range: String) {
        guard range != "" else {
            self.view.show(cities: self.data.cities)
            return
        }
        self.data.filteredCities = self.data.cities.filter({ (city) in
            city.cityNameRUS.lowercased().contains(range) || city.cityName.lowercased().contains(range)
        })
        self.view.show(cities: self.data.filteredCities)
    }
    
    //MARK: - Private
    private func updateCurrentCity(city: City) {
        rlmHelper.updateCurrentCity(city: city)
    }
    
    private func updateMyCities(city: City) {
        let curCity = rlmHelper.loadCurrentCity()
        if curCity.cityID == "" {
            rlmHelper.updateCurrentCity(city: city)
            return
        }
        rlmHelper.addItemToMyCities(city: city)
    }
}
