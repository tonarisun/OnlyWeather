//
//  CitiesListViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import RealmSwift

protocol CitiesListView: class {
    
    var configurator: CitiesListConfigurator? { get set }
}

class CitiesListViewController: UIViewController, CitiesListView {
    
    //MARK: - Outlets
    @IBOutlet weak var citiesListTableView: UITableView!
    
    //MARK: - VUPER
    var configurator: CitiesListConfigurator?
    var presenter: CitiesListPresenter?
    
    //MARK: - Data
    var cities : Results<City>?
    var token: NotificationToken?
    
    let userLanguage = NSLocale.preferredLanguages.first!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = CitiesListConfiguratorImpl()
        configurator?.configure(self)
        cities = presenter?.loadCitiesFromRLM()
        addRealmObserve()
    }
   
    func addRealmObserve() {
        self.token = cities?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.citiesListTableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .right)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .right)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .right)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    //MARK: - Actions & Selectors
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

    //MARK: - Table View
extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        guard let city = cities?[indexPath.row] else { return cell }
        if userLanguage.hasPrefix("ru") {
            cell.cityNameLabel.text = city.cityNameRUS
        } else {
            cell.cityNameLabel.text = city.cityName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(cities![indexPath.row])
                try realm.commitWrite()
            }
            catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = cities?[indexPath.row] else { return }
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
