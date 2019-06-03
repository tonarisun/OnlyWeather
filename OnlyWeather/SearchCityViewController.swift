//
//  SearchCityViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allCitiesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell", for: indexPath) as! SearchCityCell
        cell.cityNameLabel.text = "new city"
        return cell
    }

}
