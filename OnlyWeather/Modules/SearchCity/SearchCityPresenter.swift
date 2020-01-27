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
    func getCities(completion: @escaping ([City]) -> ())
    func updateCurrentCity(city: City, currentCity: CurrentCity)
    func updateMyCities(city: City)
    func cityTapped()
}

class SearchCityPresenterImpl: SearchCityPresenter {
    
    //MARK: - VUPER
    var view: SearchCityView
    var router: SearchCityRouter
    
    //MARK: - UseCases
    var getCitiesUseCase: GetCitiesUseCase?
    
    //MARK: - Data
    let db = Firestore.firestore()
    var cities = [City]()
    var filteredCities = [City]()
    let rlmHelper = RealmHelper()
    
    //MARK: - Init
    required init(view: SearchCityView,
                  router: SearchCityRouter,
                  getCitiesUseCase: GetCitiesUseCase) {
        self.view = view
        self.router = router
        self.getCitiesUseCase = getCitiesUseCase
    }
    
    //MARK: - Presenter protocol
    func getCities(completion: @escaping ([City]) -> ()) {
        getCitiesUseCase?.execute(completion: { (cities) in
            guard let cityList = cities else { return }
            completion(cityList)
        })
    }
    
    func updateCurrentCity(city: City, currentCity: CurrentCity) {
        rlmHelper.updateCurrentCity(city: city, currentCity: currentCity)
    }
    
    func updateMyCities(city: City) {
        let curCity = rlmHelper.loadCurrentCity()
        if curCity.cityID == "" {
            let cCity = CurrentCity()
            cCity.cityID = city.cityID
            cCity.cityName = city.cityName
            cCity.cityNameRUS = city.cityNameRUS
            cCity.country = city.country
            cCity.isAdded = true
            rlmHelper.updateCurrentCity(city: city, currentCity: cCity)
            return
        }
        rlmHelper.addItemToMyCities(city: city)
    }
    
    func cityTapped() {
        router.hideViewController()
    }
}
