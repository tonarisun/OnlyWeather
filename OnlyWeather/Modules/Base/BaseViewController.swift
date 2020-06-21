//
//  BaseViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

//MARK: - Constants
struct Constants {
    static let defaultNight = 22
    static let defaultDay = 7
    static let collectionCellSide = 110
    static let isRussianLanguage = "is_russian"
}

//MARK: - Protocol
protocol BaseView: class {
    
    func loadingIndicator(load: Bool)
    func showAlert(title: String?, message: String, action: (() -> ())?)
}

//MARK: - Class
class BaseViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: - Data
    var fabric: BaseFabric?
    var sections = [SectionModel]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initFabric()
    }
    
    //MARK: - Init Fabric
    func initFabric() {
        
    }
    
    //MARK: - Load Indicator
    func loadingIndicator(load: Bool) {
        self.loadingIndicator.isHidden = !load
        if load {
            self.loadingIndicator.startAnimating()
        } else {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    //MARK: - Alert
    func showAlert(title: String?, message: String, action: (() -> ())? = nil) {
        let title = title?.localized()
        let message = message.localized()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            action?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Table View Delegate / Data Source
extension BaseViewController: UITableViewDelegate, UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return self.sections.count
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return self.fabric?.cell(for: self.sections[indexPath.section].rows[indexPath.row], at: indexPath) ?? UITableViewCell()
    }
}
