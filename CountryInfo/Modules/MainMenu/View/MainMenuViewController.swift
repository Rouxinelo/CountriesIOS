//
//  MainMenuViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 16/03/2023.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
    }

    func setupViews() {
        backgroundView.backgroundColor = UIColor.lightSeaGreen
    }
}

extension MainMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
