//
//  SearchCityViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Firebase

class SearchCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allCitiesTableView: UITableView!
    var cities = [City]()
    var filteredCities = [City]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        
        db.collection("cityList").getDocuments() { (querySnapshot, err) in
            var cities = [City]()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let cityName = document.data()["cityName"] as! String
                    let cityNameRUS = document.data()["cityNameRUS"] as! String
                    let cityID = document.data()["cityID"] as! String
                    let country = document.data()["country"] as! String
                    let city = City(cityID: cityID, cityName: cityName, cityNameRUS: cityNameRUS, country: country, isAdded: false)
                    cities.append(city)
                }
            }
            self.cities = cities.sorted { $0.cityNameRUS < $1.cityNameRUS }
            self.filteredCities = self.cities
            self.allCitiesTableView.reloadData()
        }
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.allCitiesTableView.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell", for: indexPath) as! SearchCityCell
        let city = filteredCities[indexPath.row]
        cell.cityNameLabel.text = city.cityNameRUS
        return cell
    }
    
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredCities = cities
            allCitiesTableView.reloadData()
            return }
        filteredCities = cities.filter({ city -> Bool in
            return city.cityNameRUS.lowercased().contains(searchText.lowercased()) ||
                   city.cityName.lowercased().contains(searchText.lowercased())
        })
        allCitiesTableView.reloadData()
    }

    @objc func hideKeyboard() {
        allCitiesTableView?.endEditing(true)
    }
}
