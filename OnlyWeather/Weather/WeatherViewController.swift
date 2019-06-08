//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hourWeatherCollectionView: UICollectionView!
    @IBOutlet weak var dayWeatherTableView: UITableView!
    var city : City?
    let service = Service()
    var todayWeather : TodayWeather?
    var weatherList = [Weather]()
    var weatherByDay = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = city?.cityName
        service.getTodayWeather(cityID: city!.cityID) { [weak self] todayWeather in
            self?.todayWeather = todayWeather
            self?.dayWeatherTableView.reloadData()
        }
        
        service.getWeather(cityID: self.city!.cityID) { [weak self] weathers in
            self?.weatherList = weathers
            self?.weatherByDay = self!.service.sortWeatherByDay(weatherList: self!.weatherList)
            self?.dayWeatherTableView.reloadData()
            self?.hourWeatherCollectionView.reloadData()
        }
    }
//     WEATHER BY THE HOUR COLLECTIOM VIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourWeatherCell", for: indexPath) as! HourWeatherCell
        let weather = weatherList[indexPath.row]
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
            cell.contentView.backgroundColor = #colorLiteral(red: 0.3156805038, green: 0.5733602643, blue: 0.6861713529, alpha: 1)
            guard let weather = todayWeather else { return cell }
            cell.tempLabel.text = "max: \(weather.tempMax) °"
            cell.tempMinLabel.text = "min:\(weather.tempMin) °"
            cell.pressureLabel.text = "\(weather.pressure) hPa"
            cell.humidityLabel.text = "\(weather.humidity) %"
            cell.windSpeedLabel.text = "\(weather.windSpeed) m/s"
            cell.skyDescriptionLabel.text = weather.skyDescription
            setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
            cell.sunriseLabel.text = service.getTimeFromUNIXTime(date: (weather.sunrise + weather.timezone))
            cell.sunsetLabel.text = service.getTimeFromUNIXTime(date: (weather.sunset + weather.timezone))
            setSkyImageDay(skyDescription: weather.sky, imageView: cell.skyImageView)
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        let weather = weatherByDay[indexPath.row]
        if indexPath.row % 2 != 0 {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.273593694, green: 0.4941071868, blue: 0.6030237675, alpha: 1)
            setSkyImageNight(skyDescription: weather.sky, imageView: cell.skyImageView)
        } else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.3156805038, green: 0.5733602643, blue: 0.6861713529, alpha: 1)
            setSkyImageDay(skyDescription: weather.sky, imageView: cell.skyImageView)
        }
        cell.dateLabel.text = weather.day
        cell.humidityLabel.text = "\(weather.humidity) %"
        cell.pressureLabel.text = "\(weather.pressure) hPa"
        cell.tempLabel.text = "\(weather.temp) °С"
        cell.windSpeedLabel.text = "\(weather.windSpeed) m/s"
        cell.skyDescriptionLabel.text = weather.skyDescription
        setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
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
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds night")
            case "Clear":
                cell.skyImageView.image = #imageLiteral(resourceName: "clear-sky-dark")
            case "Rain":
                cell.skyImageView.image = #imageLiteral(resourceName: "rain-drops-night")
            case "Snow":
                cell.skyImageView.image = #imageLiteral(resourceName: "snowing night")
            default:
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds night")
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
                cell.skyImageView.image = #imageLiteral(resourceName: "rain-drops")
            case "Snow":
                cell.skyImageView.image = #imageLiteral(resourceName: "snowing day")
            default:
                cell.skyImageView.image = #imageLiteral(resourceName: "clouds")
            }
        }
    }
}
