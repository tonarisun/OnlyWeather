//
//  CitiesListViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

protocol CitiesListView: BaseView {
    
    func show(cities: [City])
}

class CitiesListViewController: BaseViewController, CitiesListView {
    
    //MARK: - Outlets
    @IBOutlet weak var citiesListTableView: UITableView!
    
    //MARK: - VUPER
    var configurator: CitiesListConfigurator?
    var presenter: CitiesListPresenter?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    //MARK: - Init
    override func initFabric() {
        self.fabric = CitiesListFabric(with: self.citiesListTableView)
    }
   
    //MARK: - View Protocol
    func show(cities: [City]) {
        self.sections.removeAll()
        self.sections.append(self.createCitiesSection(with: cities))
        self.citiesListTableView.reloadData()
    }
    
    //MARK: - Create Sections
    private func createCitiesSection(with cities: [City]) -> SectionModel {
        let section = SectionModel()
        
        section.rows = cities.map({ (city) -> CityRowModel in
            CityRowModel(with: city)
        })
        
        return section
    }
    
    //MARK: - Actions & Selectors
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

    //MARK: - Table View
extension CitiesListViewController {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = self.sections[indexPath.section].rows[indexPath.row].id
            self.presenter?.deleteCityFromUserCities(with: id)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.sections[indexPath.section].rows[indexPath.row].id
        self.presenter?.cityTapped(with: id)
    }
}
