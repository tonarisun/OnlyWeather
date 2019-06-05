//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    var city : City?
    let service = Service()
    var weatherList = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getTodayWeather(cityID: self.city!.cityID) { [weak self] weathers in
            self?.weatherList = weathers
            self?.weatherTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weather = weatherList[indexPath.row]
        cell.cityNameAndDateLabel.text = city!.cityNameRUS + " " + weather.date
        cell.humidityLabel.text = "\(weather.humidity) %"
        cell.pressureLabel.text = "\(weather.pressure) hPa"
        cell.tempLabel.text = "\(weather.temp) °С"
        cell.windSpeedLabel.text = "\(weather.windSpeed) m/s"
        cell.skyImageView.image = #imageLiteral(resourceName: "021-rainbow")
        switch weather.windDeg {
        case 0...15:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "015-north")
        case 15...75:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "014-north-east")
        case 76...105:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "013-east")
        case 106...165:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "012-south-east")
        case 166...195:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "011-south")
        case 196...255:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "010-south-west")
        case 256...285:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "009-west")
        case 286...345:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "008-north-west")
        case 345...360:
            cell.windDirectionImageView.image = #imageLiteral(resourceName: "015-north")
        default:
            break
        }
        return cell
    }
}
