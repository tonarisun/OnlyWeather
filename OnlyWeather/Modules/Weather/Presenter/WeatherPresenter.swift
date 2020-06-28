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
                
                self.view?.show(with: nil)//Alert(title: "oops", message: "something_wrong", action: {
//                    self.loadWeather()
//                })
                self.view?.loadingIndicator(load: false)
                return
            }
            todayWeather!.time = Int(Date().timeIntervalSince1970)
            self.data.now = (Service.getTimeFromUNIXInt(date: todayWeather!.time) ?? Constants.defaultDay) + (todayWeather?.timezone ?? 0) / 3600
            self.data.todayWeather = todayWeather ?? TodayWeather()
            self.data.currentTimezone = (todayWeather?.timezone ?? 0) / 3600
            let day = (Service.getTimeFromUNIXInt(date: todayWeather!.sunrise) ?? Constants.defaultDay) + (todayWeather?.timezone ?? 0) / 3600
            let night = (Service.getTimeFromUNIXInt(date: todayWeather!.sunset) ?? Constants.defaultNight) + (todayWeather?.timezone ?? 0) / 3600
            self.data.day = Service.correctTime(time: day)
            self.data.night = Service.correctTime(time: night)
            self.getWeatherUseCase?.execute(cityID: self.data.userCity.cityID, completion: { (success, weather) in
                if success {
                    self.data.hoursForecast = Service.getDayAndTime(weatherList: weather, timezone: self.data.currentTimezone)
                    var weatherByDay = Service.sortWeatherByDay(weatherList: weather)
                    if Service.checkTime(now: self.data.now, nextTime: weatherByDay.first?.time ?? 0) {
                        weatherByDay.removeFirst()
                    }
                    Service.getDaysOfWeek(weatherArr: weatherByDay)
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
