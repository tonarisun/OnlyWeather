//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import RealmSwift

protocol WeatherView: class {
    
    var configurator:  WeatherConfigurator? { get set }
    var currentCity:   CurrentCity? { get set }
    var todayWeather:  TodayWeather? { get set }
    var weatherByHour: [Weather] { get set }
    var weatherByDay:  [Weather] { get set }
    var currentTimezone: Int { get set }
    var day: Int? { get set }
    var night: Int? { get set }
    func refreshWeatherData()
}

class WeatherViewController: UIViewController, WeatherView {
    
    //MARK: - Outlets
    @IBOutlet weak var myCitiesButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hourWeatherCollectionView: UICollectionView!
    @IBOutlet weak var dayWeatherTableView: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    //MARK: - VUPER
    @objc var configurator: WeatherConfigurator?
    var presenter: WeatherPresenter?
    
    //MARK: - Data
    var currentCity: CurrentCity?
    var todayWeather: TodayWeather?
    var weatherByHour = [Weather]()
    var weatherByDay = [Weather]()
    var currentTimezone = 0
    var day: Int?
    var night: Int?
    var refreshControl = UIRefreshControl()
    let userLanguage = NSLocale.preferredLanguages.first!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = WeatherConfiguratorImpl()
        configurator?.configure(self)
        presenter?.viewDidLoad()
        configureLoadIndicator()
        loadIndicator.startAnimating()
        configureCollectionView()
        configureTableView()
        configureTopButtons()
        configureRefreshControl()
        dayWeatherTableView.isHidden = true
        currentCity = presenter?.loadCityFromRLM()
        guard currentCity?.cityID != "" else { return }
        configureCityNameLabel()
        presenter?.loadWeather { _ in
            self.dayWeatherTableView.isHidden = false
            self.dayWeatherTableView.reloadData()
            self.hourWeatherCollectionView.reloadData()
            self.loadIndicator.stopAnimating()
            self.loadIndicator.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshWeatherData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if currentCity?.cityID == "" {
            helloAlert()
            cityNameLabel.text = "choose a city".localized()
        }
    }
    
    private func helloAlert() {
        let hello = "Hello!".localized()
        let message = "alert message".localized()
        let alert = UIAlertController(title: hello, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.presenter?.alertBtnTapped()
            self.loadIndicator.stopAnimating()
            self.loadIndicator.isHidden = true
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Configure
    
    private func configureCollectionView() {
        hourWeatherCollectionView.delegate = self
        hourWeatherCollectionView.dataSource = self
    }
    
    private func configureTableView() {
        dayWeatherTableView.delegate = self
        dayWeatherTableView.dataSource = self
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        dayWeatherTableView.addSubview(refreshControl)
    }
    
    private func configureTopButtons() {
        let search = "search".localized()
        let myCities = "my cities".localized()
        searchButton.setTitle(search, for: .normal)
        myCitiesButton.setTitle(myCities, for: .normal)
    }
    
    private func configureCityNameLabel() {
        guard let city = currentCity else { return }
        if userLanguage.hasPrefix("ru") {
            cityNameLabel.text = city.cityNameRUS
        } else {
            cityNameLabel.text = city.cityName
        }
    }
    
    private func configureLoadIndicator() {
        loadIndicator.color = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    
    //MARK: - Actions & Selectors
    @objc func refreshWeatherData() {
        loadIndicator.isHidden = false
        loadIndicator.startAnimating()
        currentCity = presenter?.loadCityFromRLM()
        guard currentCity?.cityID != "" else { return }
        configureCityNameLabel()
        presenter?.loadWeather(completion: { _ in
            self.dayWeatherTableView.isHidden = false
            self.hourWeatherCollectionView.reloadData()
            self.dayWeatherTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.loadIndicator.stopAnimating()
            self.loadIndicator.isHidden = true
        })
    }
    
}

    //MARK: - Weather collection view
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherByHour.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourWeatherCell", for: indexPath) as! HourWeatherCell
        let weather = weatherByHour[indexPath.row]
        cell.dateLabel.text = "\(weather.time):00"
        let temp = Int(weather.temp)
        cell.tempLabel.text = "\(temp) °C"
        cell.skyLabel.text = weather.skyDescription.localized()
        setSkyImage(weather: weather, cell: cell)
        return cell
    }
}

    //MARK: - Weather Table View
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherByDay.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
            guard let weather = todayWeather else { return cell }
            if weather.time > weather.sunrise && weather.time < weather.sunset {
                setSkyImageDay(skyDescription: weather.sky, imageView: cell.skyImageView)
                cell.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
            } else {
                setSkyImageNight(skyDescription: weather.sky, imageView: cell.skyImageView)
                cell.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
            }
            let temp = NSString(format:"%.1f", weather.temp)
            cell.tempLabel.text = "\(temp) °"
            let pressure = Int(weather.pressure / 1.333)
            cell.pressureLabel.text = "\(pressure) mm"
            cell.humidityLabel.text = "\(weather.humidity) %"
            let windSpeed = Int(weather.windSpeed)
            cell.windSpeedLabel.text = "\(windSpeed) m/s"
            setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
            cell.skyDescriptionLabel.text = weather.skyDescription.localized()
            let sunrise = weather.sunrise + weather.timezone
            let sunset = weather.sunset + weather.timezone
            cell.sunriseLabel.text = Service.getTimeFromUNIXTime(date: (Double(sunrise)))
            cell.sunsetLabel.text = Service.getTimeFromUNIXTime(date: (Double(sunset)))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
            let weather = weatherByDay[indexPath.row - 1]
            let weekDay = weather.weekDay.localized()
            if weather.time > 21 || weather.time < 6 {
                cell.subView.backgroundColor = #colorLiteral(red: 0.264832288, green: 0.4864405394, blue: 0.582516849, alpha: 1)
                setSkyImageNight(skyDescription: weather.sky, imageView: cell.skyImageView)
                if indexPath.row - 1 == 0 {
                    let text = "today_night".localized()
                    cell.dateLabel.attributedText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
                } else {
                    cell.dateLabel.attributedText = nil
                }
            } else {
                cell.subView.backgroundColor = #colorLiteral(red: 0.4134832621, green: 0.6359115243, blue: 0.7319585085, alpha: 1)
                setSkyImageDay(skyDescription: weather.sky, imageView: cell.skyImageView)
                cell.dateLabel.attributedText = NSAttributedString(string: weekDay + ", \(weather.day).\(weather.month)", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            }
            cell.humidityLabel.text = "\(weather.humidity) %"
            let pressure = Int(weather.pressure / 1.333)
            cell.pressureLabel.text = "\(pressure) mm"
            let temp = NSString(format:"%.1f", weather.temp)
            cell.tempLabel.text = "\(temp) °С"
            let windSpeed = Int(weather.windSpeed)
            cell.windSpeedLabel.text = "\(windSpeed) m/s"
            setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
            cell.skyDescriptionLabel.text = weather.skyDescription.localized()
            return cell
        }
    }
}

    // MARK: - Set images
extension WeatherViewController {
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
            imageView.image = #imageLiteral(resourceName: "009-sun-1")
        case "Rain":
            imageView.image = #imageLiteral(resourceName: "029-storm-1")
        case "Snow":
            imageView.image = #imageLiteral(resourceName: "020-snow")
        case "Thunderstorm":
            imageView.image = #imageLiteral(resourceName: "011-storm-5")
        case "Drizzle":
            imageView.image = #imageLiteral(resourceName: "029-storm-1")
        case "Mist":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Smoke":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Haze":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Dust":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Fog":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Sand":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Tornado":
            imageView.image = #imageLiteral(resourceName: "026-hurricane")
        case "Ash":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Squall":
            imageView.image = #imageLiteral(resourceName: "005-wind-sign")
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
        case "Thunderstorm":
            imageView.image = #imageLiteral(resourceName: "013-storm-3")
        case "Drizzle":
            imageView.image = #imageLiteral(resourceName: "028-storm-2")
        case "Mist":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Smoke":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Haze":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Dust":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Fog":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Sand":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Tornado":
            imageView.image = #imageLiteral(resourceName: "026-hurricane")
        case "Ash":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Squall":
            imageView.image = #imageLiteral(resourceName: "005-wind-sign")
        default:
            imageView.image = #imageLiteral(resourceName: "045-cloudy-1")
        }
    }
    
    func setSkyImage(weather: Weather, cell: HourWeatherCell) {
        if weather.time > night ?? 21 || weather.time <= day ?? 6 {
            cell.dateLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.skyLabel.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
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
            cell.tempLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
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
