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

protocol SearchCityView: BaseView {
    
    func show(cities: [City])
    func addCityAlert(city: City)
}

class SearchCityViewController: BaseViewController, SearchCityView {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allCitiesTableView: UITableView!
    
    //MARK: - VUPER
    @objc var configurator: SearchCityConfigurator?
    var presenter: SearchCityPresenter?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setUpSearchBar()
        self.configureKeyboardHideGesture()
    }
    
    //MARK: - Configure
    override func initFabric() {
        self.fabric = SearcCityFabric(tableView: self.allCitiesTableView, delegate: self)
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureKeyboardHideGesture() {
        let hideKeyboardGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.direction = .down
        self.allCitiesTableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    //MARK: - Alert
    func addCityAlert(city: City) {
        let message = "added to 'my cities'".localized()
        let name = UserDefaults.standard.bool(forKey: Constants.isRussianLanguage) ? city.cityNameRUS : city.cityName
        let alert = UIAlertController(title: nil, message: "\(name) \(message)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions & Selectors
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        allCitiesTableView?.endEditing(true)
    }
    
    //MARK: - Show
    func show(cities: [City]) {
        self.sections.removeAll()
        
        self.sections.append(self.createCitiesSection(with: cities))
        
        self.allCitiesTableView.reloadData()
    }
    
    //MARK: - Create Sections
    private func createCitiesSection(with cities: [City]) -> SectionModel {
        let section = SectionModel()
        
        section.rows = cities.map({ (city) -> SearchCityRowModel in
            SearchCityRowModel(with: city)
        })
        
        return section
    }
    
}
    //MARK: - Table View
extension SearchCityViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].rows[indexPath.row]
        self.presenter?.onSelectCity(id: model.id)
    }
}

    //MARK: - SearchBar
extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.filterCities(range: searchText.lowercased())
    }
}

    //MARK: - CitySearchDelegate
extension SearchCityViewController: CitySearchDelegate {
    
    func addButtonTapped(with model: SearchCityRowModel?) {
        self.presenter?.onTapAddButton(with: model?.id)
    }
}
