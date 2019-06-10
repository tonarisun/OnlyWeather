//
//  SearchCityViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class SearchCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allCitiesTableView: UITableView!
    var cities = [City]()
    var filteredCities = [City]()
    let db = Firestore.firestore()
    let segueID = "showWeatherSegue"
    
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
                    let city = City()
                    city.cityID = cityID
                    city.cityName = cityName
                    city.country = country
                    city.cityNameRUS = cityNameRUS
                    cities.append(city)
                }
            }
            self.cities = cities.sorted { $0.cityNameRUS < $1.cityNameRUS }
            self.filteredCities = self.cities
            self.allCitiesTableView.reloadData()
        }
        
        let hideKeyboardGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.direction = .down
        self.allCitiesTableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell", for: indexPath) as! SearchCityCell
        let city = filteredCities[indexPath.row]
        cell.cityNameLabel.text = city.cityNameRUS
        cell.configure(city: city)
        cell.addCityTapped = { city in
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.add(city, update: true)
                try realm.commitWrite()
            }
            catch {
                print(error)
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueID,
        let indexPath = allCitiesTableView.indexPathForSelectedRow else { return }
        let city = filteredCities[indexPath.row]
        let currentCity = CurrentCity()
        currentCity.cityID = city.cityID
        currentCity.cityName = city.cityName
        currentCity.cityNameRUS = city.cityNameRUS
        currentCity.country = city.country
        currentCity.isAdded = city.isAdded
        do {
            let realm = try Realm()
            let oldCity = realm.objects(CurrentCity.self)
            realm.beginWrite()
            realm.add(city, update: true)
            realm.delete(oldCity)
            realm.add(currentCity)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
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
