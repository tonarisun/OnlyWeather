//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import RealmSwift

protocol WeatherView: class {
    
    var configurator:  WeatherConfigurator? { get set }
    var currentCity:   CurrentCity? { get set }
    var todayWeather:  TodayWeather? { get set }
    var weatherByHour: [Weather] { get set }
    var weatherByDay:  [Weather] { get set }
    var currentTimezone: Int { get set }
    var day: Int? { get set }
    var night: Int? { get set }
    func refreshWeatherData()
}

class WeatherViewController: UIViewController, WeatherView {
    
    //MARK: - Outlets
    @IBOutlet weak var myCitiesButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hourWeatherCollectionView: UICollectionView!
    @IBOutlet weak var dayWeatherTableView: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    //MARK: - VUPER
    @objc var configurator: WeatherConfigurator?
    var presenter: WeatherPresenter?
    
    //MARK: - Data
    var currentCity: CurrentCity?
    var todayWeather: TodayWeather?
    var weatherByHour = [Weather]()
    var weatherByDay = [Weather]()
    var currentTimezone = 0
    var day: Int?
    var night: Int?
    let helper = SkyImageHelper()
    var refreshControl = UIRefreshControl()
    let userLanguage = NSLocale.preferredLanguages.first!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = WeatherConfiguratorImpl()
        configurator?.configure(self)
        configureLoadIndicator()
        loadIndicator.startAnimating()
        configureCollectionView()
        configureTableView()
        configureTopButtons()
        configureRefreshControl()
        dayWeatherTableView.isHidden = true
        currentCity = presenter?.loadCityFromRLM()
        guard currentCity?.cityID != "" else { return }
        configureCityNameLabel()
        presenter?.loadWeather { _ in
            self.dayWeatherTableView.isHidden = false
            self.dayWeatherTableView.reloadData()
            self.hourWeatherCollectionView.reloadData()
            self.loadIndicator.stopAnimating()
            self.loadIndicator.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshWeatherData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if currentCity?.cityID == "" {
            helloAlert()
            cityNameLabel.text = "choose a city".localized()
        }
    }
    
    private func helloAlert() {
        let hello = "Hello!".localized()
        let message = "alert message".localized()
        let alert = UIAlertController(title: hello, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.presenter?.alertBtnTapped()
            self.loadIndicator.stopAnimating()
            self.loadIndicator.isHidden = true
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Configure
    private func configureCollectionView() {
        hourWeatherCollectionView.delegate = self
        hourWeatherCollectionView.dataSource = self
    }
    
    private func configureTableView() {
        dayWeatherTableView.delegate = self
        dayWeatherTableView.dataSource = self
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        dayWeatherTableView.addSubview(refreshControl)
    }
    
    private func configureTopButtons() {
        let search = "search".localized()
        let myCities = "my cities".localized()
        searchButton.setTitle(search, for: .normal)
        myCitiesButton.setTitle(myCities, for: .normal)
    }
    
    private func configureCityNameLabel() {
        guard let city = currentCity else { return }
        if userLanguage.hasPrefix("ru") {
            cityNameLabel.text = city.cityNameRUS
        } else {
            cityNameLabel.text = city.cityName
        }
    }
    
    private func configureLoadIndicator() {
        loadIndicator.color = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    
    //MARK: - Actions & Selectors
    @objc func refreshWeatherData() {
        loadIndicator.isHidden = false
        loadIndicator.startAnimating()
        currentCity = presenter?.loadCityFromRLM()
        guard currentCity?.cityID != "" else { return }
        configureCityNameLabel()
        presenter?.loadWeather(completion: { _ in
            self.dayWeatherTableView.isHidden = false
            self.hourWeatherCollectionView.reloadData()
            self.dayWeatherTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.loadIndicator.stopAnimating()
            self.loadIndicator.isHidden = true
        })
    }
}

    //MARK: - Weather collection view
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherByHour.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourWeatherCell", for: indexPath) as! HourWeatherCell
        let weather = weatherByHour[indexPath.row]
        cell.construct(with: weather)
        helper.setSkyImage(weather: weather, cell: cell, day: self.day, night: self.night)
        return cell
    }
}

    //MARK: - Weather Table View
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherByDay.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
            guard let weather = todayWeather else { return cell }
            return cell.construct(with: weather)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
            let weather = weatherByDay[indexPath.row - 1]
            return cell.construct(with: weather, row: indexPath.row)
        }
    }
}
