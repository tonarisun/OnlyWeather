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
         getCitiesUseCase: GetCitiesUseCase,
         updateCurrentCityUseCase: UpdateCurrentCityUseCase,
         updateUserCitiesUseCase: UpdateUserCitiesUseCase)
    
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
    var updateCurrentCityUseCase: UpdateCurrentCityUseCase?
    var updateUserCitiesUseCase: UpdateUserCitiesUseCase?
    
    //MARK: - Data
    let db = Firestore.firestore()
    var data = SearchData()

    //MARK: - Init
    required init(view: SearchCityView,
                  router: SearchCityRouter,
                  getCitiesUseCase: GetCitiesUseCase,
                  updateCurrentCityUseCase: UpdateCurrentCityUseCase,
                  updateUserCitiesUseCase: UpdateUserCitiesUseCase) {
        self.view = view
        self.router = router
        self.getCitiesUseCase = getCitiesUseCase
        self.updateCurrentCityUseCase = updateCurrentCityUseCase
        self.updateUserCitiesUseCase = updateUserCitiesUseCase
    }
    
    //MARK: - Life Cycle
    func viewDidLoad() {
        self.view.loadingIndicator(load: true)
        self.getCities()
    }
    
    //MARK: - Load Data
    private func getCities() {
        getCitiesUseCase?.execute(completion: { (success, cities) in
            guard success else {
                self.view.showAlert(title: "oops", message: "something_wrong", action: {
                    self.getCities()
                })
                return
            }
            self.data.cities = cities ?? [City]()
            self.data.filteredCities = self.data.cities
            self.view.show(cities: self.data.cities)
            self.view.loadingIndicator(load: false)
        })
    }
    
    //MARK: - Actions
    func onSelectCity(id: String?) {
        if let selectedCity = self.data.cities.first(where: { (city) in
            city.cityID == id
        }) {
            self.updateCurrentCityUseCase?.execute(city: selectedCity, completion: { (success) in
                self.router.hideViewController()
            })
        }
    }
    
    func onTapAddButton(with cityID: String?) {
        if let addedCity = self.data.cities.first(where: { (city) in
            city.cityID == cityID
        }) {
            self.updateUserCitiesUseCase?.execute(city: addedCity, completion: { (success) in
                self.view.showAlert(title: nil, message: "added to 'my cities'", action: nil)
            })
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
}
