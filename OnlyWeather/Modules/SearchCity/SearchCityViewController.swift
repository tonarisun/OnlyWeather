//
//  SearchCityViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import RealmSwift

protocol SearchCityView {
    
    var configurator: SearchCityConfigurator? { get set }
}

class SearchCityViewController: UIViewController, SearchCityView {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allCitiesTableView: UITableView!
    
    //MARK: - VUPER
    var configurator: SearchCityConfigurator?
    var presenter: SearchCityPresenter?
    
    //MARK: - Data
    var cities = [City]()
    var filteredCities = [City]()
    let userLanguage = NSLocale.preferredLanguages.first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = SearchCityConfiguratorImpl()
        configurator?.configure(self)
        setUpSearchBar()
            
        presenter?.getCities(completion: { (cities) in
            self.cities = cities.sorted { $0.cityNameRUS < $1.cityNameRUS }
            self.filteredCities = self.cities
            self.allCitiesTableView.reloadData()
        })
        
        let hideKeyboardGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.direction = .down
        self.allCitiesTableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    //MARK: - Alert
    private func addCityAlert(city: String) {
        let message = "added to 'my cities'".localized()
        let alert = UIAlertController(title: nil, message: "\(city) \(message)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    private func addCityAlertLang(city: City) {
        if userLanguage.hasPrefix("ru") {
            addCityAlert(city: city.cityNameRUS)
        } else {
            addCityAlert(city: city.cityName)
        }
    }
    
    //MARK: - Actions & Selectors
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        allCitiesTableView?.endEditing(true)
    }
}
    //MARK: - Table View
extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell", for: indexPath) as! SearchCityCell
        let city = filteredCities[indexPath.row]
        if userLanguage.hasPrefix("ru") {
            cell.cityNameLabel.text = city.cityNameRUS
        } else {
            cell.cityNameLabel.text = city.cityName
        }
        cell.configure(city: city)
        cell.addCityTapped = { city in
            self.presenter?.updateMyCities(city: city)
            self.addCityAlertLang(city: city)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = filteredCities[indexPath.row]
        let currentCity = CurrentCity()
        currentCity.cityID = city.cityID
        currentCity.cityName = city.cityName
        currentCity.cityNameRUS = city.cityNameRUS
        currentCity.country = city.country
        currentCity.isAdded = city.isAdded
        presenter?.updateCurrentCity(city: city, currentCity: currentCity)
        presenter?.cityTapped()
    }
    
}

    //MARK: - SearchBar
extension SearchCityViewController: UISearchBarDelegate {
    
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredCities = cities
            allCitiesTableView.reloadData()
            return }
        filteredCities = cities.filter { city -> Bool in
            return city.cityNameRUS.lowercased().contains(searchText.lowercased()) ||
                   city.cityName.lowercased().contains(searchText.lowercased())
        }
        allCitiesTableView.reloadData()
    }
}

