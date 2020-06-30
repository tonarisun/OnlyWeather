//
//  WeatherViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 03/06/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

protocol WeatherView: BaseView {
    
    func configureCityNameLabel(_ city: String)
    func show(with forecast: ForecastData?)
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
    var showEmptyView = false
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.tableView.contentInset.top = 10
        self.tableView.contentInset.bottom = 20
    }
    
    private func configureRefreshControl() {
        self.refreshControl.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
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
    func show(with forecast: ForecastData?) {
        self.showEmptyView = forecast == nil
        self.sections.removeAll()
        self.sections.append(self.createTodayWeatherSection(with: forecast?.todayWeather))
        self.sections.append(self.createNewHoursForecastSection(with: forecast?.hoursForecast))
        self.sections.append(self.createDailyForecastSection(with: forecast?.daysForecast))
        self.tableView.reloadData()
    }
    
    //MARK: - Create Sections
    private func createNewHoursForecastSection(with forecast: [Weather]?) -> SectionModel {
        let section = SectionModel()
        
        guard let hoursForecast = forecast  else { return section }
        
        let tableRow = NEWHoursWeatherTableRowModel(id: UUID().uuidString)
        
        let collSection = SectionModel()
        collSection.rows = hoursForecast.map({ (weather) -> NEWHourWeatherRowModel in
            return NEWHourWeatherRowModel(with: weather)
        })
        
        tableRow.sections.append(collSection)
        section.rows.append(tableRow)
        
        return section
    }
    
    private func createTodayWeatherSection(with weather: TodayWeather?) -> SectionModel {
        let section = SectionModel()
        
        guard let todayWeather = weather else { return section }
        
        let row = TodayWeatherRowModel(with: todayWeather)
        section.rows = [row]
        
        return section
    }
    
    private func createDailyForecastSection(with forecast: [Weather]?) -> SectionModel {
        let section = SectionModel()
        
        guard let dailyForecast = forecast else { return section }

        dailyForecast.enumerated().forEach { (index, weather) in
            guard index < dailyForecast.count-1 else { return }
            if weather.weekDay == dailyForecast[index + 1].weekDay {
                let row = DayWeatherRowModel()
                row.weekDay = weather.weekDay
                if weather.isDay {
                    row.tempDay = NSString(format:"%.1f", weather.temp) as String
                    row.skyDay = weather.sky
                    row.tempNight = NSString(format:"%.1f", dailyForecast[index + 1].temp) as String
                    row.skyNight = dailyForecast[index + 1].sky
                } else {
                    row.tempNight = NSString(format:"%.1f", weather.temp) as String
                    row.skyNight = weather.sky
                    row.tempDay = NSString(format:"%.1f", dailyForecast[index + 1].temp) as String
                    row.skyDay = dailyForecast[index + 1].sky
                }
                section.rows.append(row)
            }
        }
        
        return section
    }
}

//MARK: - EmptyDataSet
extension WeatherViewController: EmptyDataSetDelegate, EmptyDataSetSource {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        self.refreshControl.endRefreshing()
        return self.showEmptyView
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return #imageLiteral(resourceName: "cloudy-smile")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "something_wrong".localized(), attributes: self.stringAttributes(size: 19))
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        return NSAttributedString(string: "OK", attributes: self.stringAttributes(size: 22))
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        self.presenter?.refreshData()
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 40.0
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -30.0
    }
    
    func stringAttributes(size: CGFloat) -> [NSAttributedString.Key: Any] {
        let font = UIFont(name: "Avenir Next Demi Bold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                         .paragraphStyle: paragraphStyle,
                                                         .foregroundColor: UIColor.white]
        return attributes
    }
}
