//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hourWeatherCollectionView: UICollectionView!
    @IBOutlet weak var dayWeatherTableView: UITableView!
    var currentCity : CurrentCity?
    let service = Service()
    var todayWeather : TodayWeather?
    var weatherList = [Weather]()
    var weatherByHour = [Weather]()
    var weatherByDay = [Weather]()
    var refreshControl = UIRefreshControl()
    let userLanguage = NSLocale.preferredLanguages.first!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        guard currentCity != nil else {
            if userLanguage.hasPrefix("ru") {
               addCityAlertRUS()
            } else {
                if userLanguage.hasPrefix("de") {
                    AddCityAlertDE()
                } else {
                   AddCityAlertENG()
                }
            }
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCityFromRLM()
        
        guard currentCity != nil else {
            return
        }
        
        addRefreshControl()
        
        if userLanguage.hasPrefix("ru") {
            cityNameLabel.text = currentCity!.cityNameRUS
        } else {
            cityNameLabel.text = currentCity!.cityName
        }
        
        service.getTodayWeather(cityID: currentCity!.cityID) { [weak self] todayWeather in
            self?.todayWeather = todayWeather
            self?.dayWeatherTableView.reloadData()
        }
        
        service.getWeather(cityID: currentCity!.cityID) { [weak self] weathers in
            self?.weatherList = weathers
            self?.weatherByDay = self!.service.sortWeatherByDay(weatherList: self!.weatherList)
            self?.weatherByHour = self!.service.ifTimeLater(weatherList: self!.weatherList)
            self?.dayWeatherTableView.reloadData()
            self?.hourWeatherCollectionView.reloadData()
        }
    }
    
    func loadCityFromRLM() {
        do {
            let realm = try Realm()
            self.currentCity = realm.objects(CurrentCity.self).first
        } catch {
            print(error)
        }
    }
    
    func addCityAlertRUS() {
        let alert = UIAlertController(title: "Привет!", message: "Нажми на 'поиск' и выбери нужный город. Можно добавить сразу несколько городов в список или выбрать один", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func AddCityAlertENG() {
        let alert = UIAlertController(title: "Hello!", message: "Tap 'search' and find your city. You can add several cities or choose one of them", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func AddCityAlertDE() {
        let alert = UIAlertController(title: "Hallo!", message: "Klicken Sie auf 'suchen' und wählen Sie die gewünschte Stadt aus. Sie können mehrere Städte hinzufügen oder eine auswählen.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addRefreshControl() {
        refreshControl.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        dayWeatherTableView.addSubview(refreshControl)
    }
    
    @objc func refreshWeatherData() {
        guard currentCity != nil else { return }
        
        service.getTodayWeather(cityID: currentCity!.cityID) { [weak self] todayWeather in
            self?.todayWeather = todayWeather
        }
        
        service.getWeather(cityID: currentCity!.cityID) { [weak self] weathers in
            self?.weatherList = weathers
            self?.weatherByDay = self!.service.sortWeatherByDay(weatherList: self!.weatherList)
            self?.weatherByHour = self!.service.ifTimeLater(weatherList: self!.weatherList)
        }
        refreshControl.endRefreshing()
        hourWeatherCollectionView.reloadData()
        dayWeatherTableView.reloadData()
    }
    
//     WEATHER BY THE HOUR COLLECTIOM VIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherByHour.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourWeatherCell", for: indexPath) as! HourWeatherCell
        let weather = weatherByHour[indexPath.row]
        cell.dateLabel.text = weather.shortDate
        let temp = Int(weather.temp)
        cell.tempLabel.text = "\(temp) °C"
        cell.skyLabel.text = weather.skyDescription
       setSkyImage(weather: weather, cell: cell)
        return cell
    }
    
//    WEATHER BY THE DAY TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherByDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
            guard let weather = todayWeather else { return cell }
            cell.tempLabel.text = "\(weather.temp) °"
            let pressure = Int(weather.pressure / 1.333)
            cell.pressureLabel.text = "\(pressure) mm"
            cell.humidityLabel.text = "\(weather.humidity) %"
            let windSpeed = Int(weather.windSpeed)
            cell.windSpeedLabel.text = "\(windSpeed) m/s"
            setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
            cell.skyDescriptionLabel.text = weather.skyDescription
            let sunrise = weather.sunrise + weather.timezone
            let sunset = weather.sunset + weather.timezone
            cell.sunriseLabel.text = service.getTimeFromUNIXTime(date: (sunrise))
            cell.sunsetLabel.text = service.getTimeFromUNIXTime(date: (sunset))
            setSkyImageDay(skyDescription: weather.sky, imageView: cell.skyImageView)
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        let weather = weatherByDay[indexPath.row - 1]
        if indexPath.row % 2 != 0 {
            cell.subView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            setSkyImageNight(skyDescription: weather.sky, imageView: cell.skyImageView)
        } else {
            cell.subView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            setSkyImageDay(skyDescription: weather.sky, imageView: cell.skyImageView)
        }
            cell.dateLabel.attributedText = NSAttributedString(string: weather.day, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        cell.humidityLabel.text = "\(weather.humidity) %"
        let pressure = Int(weather.pressure / 1.333)
        cell.pressureLabel.text = "\(pressure) mm"
        cell.tempLabel.text = "\(weather.temp) °С"
        let windSpeed = Int(weather.windSpeed)
        cell.windSpeedLabel.text = "\(windSpeed) m/s"
        setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
        cell.skyDescriptionLabel.text = weather.skyDescription
        return cell
        }
    }

    
    func setWindDirectionImage(degree: Double, imageView: UIImageView) {
        switch degree {
        case 0...15:
            imageView.image = #imageLiteral(resourceName: "north")
        case 15.1...75:
            imageView.image = #imageLiteral(resourceName: "north-east")
        case 75.1...105:
            imageView.image = #imageLiteral(resourceName: "east")
        case 105.1...165:
            imageView.image = #imageLiteral(resourceName: "south-east")
        case 165.1...195:
            imageView.image = #imageLiteral(resourceName: "south")
        case 195.1...255:
            imageView.image = #imageLiteral(resourceName: "south-west")
        case 255.1...285:
            imageView.image = #imageLiteral(resourceName: "west")
        case 285.1...345:
            imageView.image = #imageLiteral(resourceName: "north-west")
        case 345.1...361:
            imageView.image = #imageLiteral(resourceName: "north")
        default:
            break
        }
    }
    
    func setSkyImageDay(skyDescription: String, imageView: UIImageView) {
        switch skyDescription {
        case "Clouds":
            imageView.image = #imageLiteral(resourceName: "046-cloudy")
        case "Clear":
            imageView.image = #imageLiteral(resourceName: "010-sun")
        case "Rain":
            imageView.image = #imageLiteral(resourceName: "029-storm-1")
        case "Snow":
            imageView.image = #imageLiteral(resourceName: "029-storm-1")
        default:
            imageView.image = #imageLiteral(resourceName: "046-cloudy")
        }
    }
    
    func setSkyImageNight(skyDescription: String, imageView: UIImageView) {
        switch skyDescription {
        case "Clouds":
            imageView.image = #imageLiteral(resourceName: "045-cloudy-1")
        case "Clear":
            imageView.image = #imageLiteral(resourceName: "048-night")
        case "Rain":
            imageView.image = #imageLiteral(resourceName: "028-storm-2")
        case "Snow":
            imageView.image = #imageLiteral(resourceName: "018-snowy")
        default:
            imageView.image = #imageLiteral(resourceName: "045-cloudy-1")
        }
    }
    
    func setSkyImage(weather: Weather, cell: HourWeatherCell){
        if weather.time == "00" || weather.time == "03" || weather.time == "21" {
            cell.dateLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.skyLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            switch weather.sky {
            case "Clouds":
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds-night")
            case "Clear":
                cell.skyImageView.image = #imageLiteral(resourceName: "clear sky night")
            case "Rain":
                cell.skyImageView.image = #imageLiteral(resourceName: "rain-drops-night")
            case "Snow":
                cell.skyImageView.image = #imageLiteral(resourceName: "snowing night")
            default:
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds-night")
            }
        } else {
            cell.dateLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.skyLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            switch weather.sky {
            case "Clouds":
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds")
            case "Clear":
                cell.skyImageView.image = #imageLiteral(resourceName: "clear-sky")
            case "Rain":
                cell.skyImageView.image = #imageLiteral(resourceName: "rain-drops-day")
            case "Snow":
                cell.skyImageView.image = #imageLiteral(resourceName: "snowing day")
            default:
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds")
            }
        }
    }
}
