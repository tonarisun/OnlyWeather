//
//  ViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class CitiesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var citiesListTableView: UITableView!
    var cities = [City]()
    let showWeatherSegueID = "showWeatherSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cities = [City(cityID: "2644210", cityName: "Liverpool", cityNameRUS: "Ливерпуль", country: "GB", isAdded: true),
                  City(cityID: "2673730", cityName: "Stockholm", cityNameRUS: "Стокгольм", country: "SE", isAdded: true)]
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let city = cities[indexPath.row]
        cell.cityNameLabel.text = city.cityName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == showWeatherSegueID,
        let indexPath = citiesListTableView.indexPathForSelectedRow else { return }
        let city = cities[indexPath.row]
        let weatherVC = segue.destination as! WeatherViewController
        weatherVC.city = city
    }
    

}

