//
//  BaseViewController.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 19.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

struct Constants {
    static let defaultNight = 22
    static let defaultDay   = 7
    static let collectionCellSide = 110
}

protocol BaseView: class {
    
    func loadingIndicator(load: Bool)
}

class BaseViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var fabric: BaseFabric?
    var sections = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initFabric()
    }
    
    func initFabric() {
        
    }
    
    func loadingIndicator(load: Bool) {
        self.loadingIndicator.isHidden = !load
        if load {
            self.loadingIndicator.startAnimating()
        } else {
            self.loadingIndicator.stopAnimating()
        }
    }
    
}

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
