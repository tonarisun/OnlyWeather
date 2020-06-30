//
//  WeatherPresenter.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 05.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import RealmSwift

protocol WeatherPresenter: class {

    init(view: WeatherView,
         router: WeatherRouter,
         getCurrentCityUseCase: GetCurrentCityUseCase,
         getWeatherUseCase: GetWeatherUseCase,
         getTodayWeatherUseCase: GetTodayWeatherUseCase)
    
    func viewWillAppear()
    func viewDidAppear()
    
    func searchCityBtnTapped()
    func myCitiesBtnTapped()
    func refreshData()
}

class WeatherPresenterImpl: WeatherPresenter {
    
    
    //MARK: - VUPER
    weak var view: WeatherView?
    var router: WeatherRouter?
    
    //MARK: - UseCases
    var getCurrentCityUseCase: GetCurrentCityUseCase?
    var getWeatherUseCase: GetWeatherUseCase?
    var getTodayWeatherUseCase: GetTodayWeatherUseCase?
    
    //MARK: - Data
    var token: NotificationToken!
    var data = ForecastData()
    
    //MARK: - Init
    required init(view: WeatherView,
                  router: WeatherRouter,
                  getCurrentCityUseCase: GetCurrentCityUseCase,
                  getWeatherUseCase: GetWeatherUseCase,
                  getTodayWeatherUseCase: GetTodayWeatherUseCase) {
        self.view = view
        self.router = router
        self.getCurrentCityUseCase = getCurrentCityUseCase
        self.getWeatherUseCase = getWeatherUseCase
        self.getTodayWeatherUseCase = getTodayWeatherUseCase
    }
    
    //MARK: - Life Cycle
    func viewWillAppear() {
        self.loadCityFromRLM()
    }
    
    func viewDidAppear() {
        if self.data.userCity.cityID == "" {
            self.view?.configureCityNameLabel("choose a city".localized())
            self.view?.showAlert(title: "Hello!", message: "alert message", action: {
                self.searchCityBtnTapped()
            })
        }
    }
    
    //MARK: - Load Data
    private func loadCityFromRLM() {
        self.view?.loadingIndicator(load: true)
        self.getCurrentCityUseCase?.execute(completion: { (city) in
            self.data.userCity = city
            self.addRealmObserve()
            guard city.cityID != "" else { return }
            let name = UserDefaults.standard.bool(forKey: Constants.isRussianLanguage) ? city.cityNameRUS : city.cityName
            self.view?.configureCityNameLabel(name)
            self.loadWeather()
        })
    }
    
    private func loadWeather() {
        getTodayWeatherUseCase?.execute(cityID: self.data.userCity.cityID, completion: { (success, todayWeather) in
            guard success else {
                
                self.view?.show(with: nil)
                self.view?.loadingIndicator(load: false)
                return
            }
            todayWeather!.time = Int(Date().timeIntervalSince1970)
            CurrentCityTime.instance.now = (Date.getTimeInt(date: todayWeather!.time) ?? Constants.defaultDay) + ((todayWeather?.timezone ?? 0) / 3600)
            self.data.todayWeather = todayWeather ?? TodayWeather()
            CurrentCityTime.instance.currentTimezone = todayWeather?.timezone ?? 0
            let day = (Date.getTimeInt(date: todayWeather!.sunrise) ?? Constants.defaultDay) + ((todayWeather?.timezone ?? 0) / 3600)
            let night = (Date.getTimeInt(date: todayWeather!.sunset) ?? Constants.defaultNight) + ((todayWeather?.timezone ?? 0) / 3600)
            CurrentCityTime.instance.day = Service.correctTime(time: day)
            CurrentCityTime.instance.night = Service.correctTime(time: night)
            self.getWeatherUseCase?.execute(cityID: self.data.userCity.cityID, completion: { (success, weather) in
                if success, let weathersList = weather {
                    Service.dateForWeatherItems(weathersList: weathersList, timezone: CurrentCityTime.instance.currentTimezone)
                    self.data.hoursForecast = weathersList
                    var weatherByDay = Service.sortWeatherByDay(weatherList: weathersList)
                    if Service.checkTime(nextTime: weatherByDay.first?.timeInt ?? 0) {
                        weatherByDay.removeFirst()
                    }
                    self.data.daysForecast = weatherByDay
                    self.view?.show(with: self.data)
                    self.view?.loadingIndicator(load: false)
                }
            })
        })
    }
    
    //MARK: - Realm Observe
    private func addRealmObserve() {
        token = self.data.userCity.observe { (changes: ObjectChange) in
            switch changes {
            case .error(let error):
                print(error)
            case .change, .deleted:
                self.refreshData()
            }
        }
    }

    //MARK: - Actions
    func refreshData() {
        self.loadCityFromRLM()
    }
    
    func searchCityBtnTapped() {
        self.router?.openSearchCityVC()
    }
    
    func myCitiesBtnTapped() {
        self.router?.openMyCitiesVC()
    }
}
