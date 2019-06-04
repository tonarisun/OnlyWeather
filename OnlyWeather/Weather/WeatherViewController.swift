//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var city : City?
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherView: WeatherView!
    let service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.loadWeatherData(cityID: self.city!.cityID) { [weak self] weatherResponse in
            self?.cityNameLabel.text = self?.city?.cityName
            self?.weatherView!.tempLabel.text = "\(weatherResponse.temp) °С"
            self?.weatherView!.humidityLabel.text = "\(weatherResponse.humidity) %"
            self?.weatherView!.maxTempLabel.text = "max. \(weatherResponse.max_temp) °С"
            self?.weatherView!.minTempLabel.text = "min. \(weatherResponse.min_temp) °С"
            self?.weatherView!.pressureLabel.text = "\(weatherResponse.pressure) hPa"
            self?.weatherView!.sunRiseLabel.text = self?.service.getTimeFromUNIXTime(date: weatherResponse.sunrise)
            self?.weatherView!.sunSetLabel.text = self?.service.getTimeFromUNIXTime(date: weatherResponse.sunset)
            self?.weatherView!.windSpeedLabel.text = "\(weatherResponse.windSpeed) m/s"
            switch weatherResponse.windDeg {
            case 0...90:
                self?.weatherView!.windDirectLabel.text = "NW"
            case 91...180:
                self?.weatherView!.windDirectLabel.text = "SW"
            case 181...270:
                self?.weatherView!.windDirectLabel.text = "SE"
            case 271...360:
                self?.weatherView!.windDirectLabel.text = "NE"
            default: break
            }
        }
    }
}
