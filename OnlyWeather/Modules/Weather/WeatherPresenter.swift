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
    func loadCityFromRLM() -> CurrentCity
    func loadWeather(completion: @escaping (Bool) -> ())
    func alertBtnTapped()
}

class WeatherPresenterImpl: WeatherPresenter {
    
    //MARK: - VUPER
    weak var view: WeatherView?
    var router: WeatherRouter?
    
    //MARK: - UseCases
    var getWeatherUseCase: GetWeatherUseCase?
    var getTodayWeatherUseCase: GetTodayWeatherUseCase?
    
    //MARK: - Data
    var currentCity : CurrentCity?
    let service = Service()
    let rlmHelper = RealmHelper()
    let userLanguage = NSLocale.preferredLanguages.first!
    let sunriseConst = 7
    let sunsetConst = 21
    var now = 0
    var token: NotificationToken!
    
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
    
    //MARK: - Presenter protocol
    func loadCityFromRLM() -> CurrentCity {
        let currentCity = rlmHelper.loadCurrentCity()
        self.currentCity = currentCity
        addRealmObserve()
        return currentCity
    }
    
    func loadWeather(completion: @escaping (Bool) -> ()) {
        guard let city = currentCity else { return }
        getTodayWeatherUseCase?.execute(cityID: city.cityID, completion: { (success, todayWeather) in
            if success {
                todayWeather!.time = Int(Date().timeIntervalSince1970)
                self.now = (self.service.getTimeFromUNIXInt(date: todayWeather!.time) ?? self.sunriseConst) + (todayWeather?.timezone ?? 0) / 3600
                self.view?.todayWeather = todayWeather
                self.view?.currentTimezone = todayWeather!.timezone / 3600
                let day = (self.service.getTimeFromUNIXInt(date: todayWeather!.sunrise) ?? self.sunriseConst) + (todayWeather?.timezone ?? 0) / 3600
                let night = (self.service.getTimeFromUNIXInt(date: todayWeather!.sunset) ?? self.sunsetConst) + (todayWeather?.timezone ?? 0) / 3600
                self.view?.day = self.service.correctTime(time: day)
                self.view?.night = self.service.correctTime(time: night)
                self.getWeatherUseCase?.execute(cityID: city.cityID, completion: { (success, weather) in
                    if success {
                        self.view?.weatherByHour = self.service.getDayAndTime(weatherList: weather!, timezone: self.view?.currentTimezone ?? 0)
                        var weatherByDay = self.service.sortWeatherByDay(weatherList: weather!)
                        if self.service.checkTime(now: self.now, nextTime: weatherByDay.first?.time ?? 0) {
                            weatherByDay.removeFirst()
                        }
                        self.view?.weatherByDay = weatherByDay
                        self.service.getDaysOfWeek(weatherArr: self.view!.weatherByDay)
                        completion(true)
                    }
                })
            }
        })
    }
    
    func addRealmObserve() {
        token = currentCity?.observe { (changes: ObjectChange) in
            switch changes {
            case .error(let error):
                print(error)
            case .change, .deleted:
                self.view?.refreshWeatherData()
            }
        }
    }
    
    func alertBtnTapped() {
        router?.openSearchCityVC()
    }
}
