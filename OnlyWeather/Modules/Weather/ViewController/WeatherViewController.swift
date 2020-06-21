//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import RealmSwift

protocol WeatherView: BaseView {
    
    func configureCityNameLabel(_ city: String)
    func show(with forecast: ForecastData)
}

class WeatherViewController: BaseViewController, WeatherView {
    
    //MARK: - Outlets
    @IBOutlet weak var myCitiesButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - VUPER
    @objc var configurator: WeatherConfigurator?
    var presenter: WeatherPresenter?
    
    //MARK: - Data
    let refreshControl = UIRefreshControl()
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
        self.configureTableView()
        self.configureRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.presenter?.viewDidAppear()
    }
    
    //MARK: - Configure
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func configureCityNameLabel(_ city: String) {
        cityNameLabel.text = city
    }
    
    //MARK: - Init
    override func initFabric() {
        self.fabric = WeatherFabric(with: self.tableView)
    }
    
    //MARK: - Actions & Selectors
    @objc func refreshWeatherData() {
        self.refreshControl.beginRefreshing()
        self.presenter?.refreshData()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.presenter?.searchCityBtnTapped()
    }
    
    @IBAction func myCitiesButtonTapped(_ sender: Any) {
        self.presenter?.myCitiesBtnTapped()
    }
    
    //MARK: - Show
    func show(with forecast: ForecastData) {
        self.sections.removeAll()
        self.sections.append(self.createHoursForecastSection(with: forecast.hoursForecast, day: forecast.day, night: forecast.night))
        self.sections.append(self.createTodayWeatherSection(with: forecast.todayWeather))
        self.sections.append(self.createDailyForecastSection(with: forecast.daysForecast))
        self.tableView.reloadData()
    }
    
    //MARK: - Create Sections
    private func createHoursForecastSection(with forecast: [Weather], day: Int, night: Int) -> SectionModel {
        let section = SectionModel()
        let tableRow = HoursWeatherTableRowModel()
        tableRow.day = day
        tableRow.night = night
        
        let collSection = SectionModel()
        collSection.rows = forecast.map({ (weather) -> HourWeatherRowModel in
            return HourWeatherRowModel(with: weather)
        })
        
        tableRow.sections.append(collSection)
        section.rows.append(tableRow)
        
        return section
    }
    
    private func createTodayWeatherSection(with weather: TodayWeather) -> SectionModel {
        let section = SectionModel()
        
        let row = TodayWeatherRowModel(with: weather)
        section.rows = [row]
        
        return section
    }
    
    private func createDailyForecastSection(with forecast: [Weather]) -> SectionModel {
        let section = SectionModel()
        
        section.rows = forecast.map({ (weather) -> DayWeatherRowModel in
            return DayWeatherRowModel(with: weather)
        })
        
        return section
    }
}
