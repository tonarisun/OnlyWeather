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
         getWeatherUseCase: GetWeatherUseCase,
         getTodayWeatherUseCase: GetTodayWeatherUseCase)
    
    func viewWillAppear()
    func viewDidAppear()
    
    func loadCityFromRLM()
    func loadWeather()
    func searchCityBtnTapped()
    func refreshData()
}

class WeatherPresenterImpl: WeatherPresenter {
    
    
    //MARK: - VUPER
    weak var view: WeatherView?
    var router: WeatherRouter?
    
    //MARK: - UseCases
    var getWeatherUseCase: GetWeatherUseCase?
    var getTodayWeatherUseCase: GetTodayWeatherUseCase?
    
    //MARK: - Data
    let service = Service()
    let rlmHelper = RealmHelper()
    var token: NotificationToken!
//    let userLanguage = NSLocale.preferredLanguages.first!
    let sunriseConst = 7
    let sunsetConst = 21
    var data = ForecastData()
    
    //MARK: - Init
    required init(view: WeatherView,
                  router: WeatherRouter,
                  getWeatherUseCase: GetWeatherUseCase,
                  getTodayWeatherUseCase: GetTodayWeatherUseCase) {
        self.view = view
        self.router = router
        self.getWeatherUseCase = getWeatherUseCase
        self.getTodayWeatherUseCase = getTodayWeatherUseCase
    }
    
    //MARK: - Life Cycle
    func viewWillAppear() {
        self.loadCityFromRLM()
    }
    
    func viewDidAppear() {
        if self.data.userCity.cityID == "" {
            self.view?.showHelloAlert()
        }
    }
    
    //MARK: - Presenter protocol
    func loadCityFromRLM() {
        let currentCity = rlmHelper.loadCurrentCity()
        self.data.userCity = currentCity
        if currentCity.cityID == "" {
            return
        }
        self.addRealmObserve()
        self.loadWeather()
    }
    
    func loadWeather() {
        getTodayWeatherUseCase?.execute(cityID: self.data.userCity.cityID, completion: { (success, todayWeather) in
            if success {
                todayWeather!.time = Int(Date().timeIntervalSince1970)
                self.data.now = (self.service.getTimeFromUNIXInt(date: todayWeather!.time) ?? self.sunriseConst) + (todayWeather?.timezone ?? 0) / 3600
                self.data.todayWeather = todayWeather ?? TodayWeather()
                self.data.currentTimezone = todayWeather!.timezone / 3600
                let day = (self.service.getTimeFromUNIXInt(date: todayWeather!.sunrise) ?? self.sunriseConst) + (todayWeather?.timezone ?? 0) / 3600
                let night = (self.service.getTimeFromUNIXInt(date: todayWeather!.sunset) ?? self.sunsetConst) + (todayWeather?.timezone ?? 0) / 3600
                self.data.day = self.service.correctTime(time: day)
                self.data.night = self.service.correctTime(time: night)
                self.getWeatherUseCase?.execute(cityID: self.data.userCity.cityID, completion: { (success, weather) in
                    if success {
                        self.data.hoursForecast = self.service.getDayAndTime(weatherList: weather!, timezone: self.data.currentTimezone)
                        var weatherByDay = self.service.sortWeatherByDay(weatherList: weather!)
                        if self.service.checkTime(now: self.data.now, nextTime: weatherByDay.first?.time ?? 0) {
                            weatherByDay.removeFirst()
                        }
                        self.service.getDaysOfWeek(weatherArr: weatherByDay)
                        self.data.daysForecast = weatherByDay
                        self.view?.show(with: self.data)
                        self.view?.loadingIndicator(load: false)
                    }
                })
            }
        })
    }
    
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

    
    func refreshData() {
        self.view?.loadingIndicator(load: true)
        self.loadCityFromRLM()
    }
    
    func searchCityBtnTapped() {
        router?.openSearchCityVC()
    }
}
