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
    var weatherList = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = city?.cityName
        service.getTodayWeather(cityID: self.city!.cityID) { [weak self] weathers in
            self?.weatherList = weathers
            self?.dayWeatherTableView.reloadData()
            self?.hourWeatherCollectionView.reloadData()
            weathers.first?.shortDate = (self?.dateToShort(string: weathers.first!.date))!
            print(weathers.first?.shortDate ?? "default value")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourWeatherCell", for: indexPath) as! HourWeatherCell
        let weather = weatherList[indexPath.row]
        cell.dateLabel.text = dateToShort(string: weather.date) 
        cell.tempLabel.text = "\(weather.temp) °С"
        cell.skyLabel.text = weather.skyDiscription
        if weather.sky == "Clouds" {
            cell.skyImageView.image = #imageLiteral(resourceName: "clouds")
        } else {
            if weather.sky == "Rain" {
               cell.skyImageView.image = #imageLiteral(resourceName: "rain-drops")
            } else {
                cell.skyImageView.image = #imageLiteral(resourceName: "clear-sky")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        let weather = weatherList[indexPath.row]
        cell.dateLabel.text = dateToShort(string: weather.date) 
        cell.humidityLabel.text = "\(weather.humidity) %"
        cell.pressureLabel.text = "\(weather.pressure) hPa"
        cell.tempLabel.text = "\(weather.temp) °С"
        cell.windSpeedLabel.text = "\(weather.windSpeed) m/s"
        cell.skyImageView.image = #imageLiteral(resourceName: "002-windy-1")
        setWindDirectionImage(degree: weather.windDeg, imageView: cell.windDirectionImageView)
        return cell
    }
    
    func setWindDirectionImage(degree: Double, imageView: UIImageView) {
        switch degree {
        case 0...15:
            imageView.image = #imageLiteral(resourceName: "015-north")
        case 15.1...75:
            imageView.image = #imageLiteral(resourceName: "014-north-east")
        case 75.1...105:
            imageView.image = #imageLiteral(resourceName: "013-east")
        case 105.1...165:
            imageView.image = #imageLiteral(resourceName: "012-south-east")
        case 165.1...195:
            imageView.image = #imageLiteral(resourceName: "011-south")
        case 195.1...255:
            imageView.image = #imageLiteral(resourceName: "010-south-west")
        case 255.1...285:
            imageView.image = #imageLiteral(resourceName: "009-west")
        case 285.1...345:
            imageView.image = #imageLiteral(resourceName: "008-north-west")
        case 345.1...361:
            imageView.image = #imageLiteral(resourceName: "015-north")
        default:
            break
        }
    }
    
    func dateToShort(string: String) -> String {
        var charArray = Array(string)
        for _ in 0...4 {
            charArray.removeFirst()
        }
        for _ in 0...2 {
            charArray.removeLast()
        }
        let newString = String(charArray)
        return newString
    }
}
