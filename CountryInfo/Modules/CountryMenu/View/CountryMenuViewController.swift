//
//  CountryMenuViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 17/03/2023.
//

import UIKit

class CountryMenuViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        setupBackgroundView()
        setupSearchBar()
        setupTableView()
    }
    
    func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor.lightSeaGreen
    }
    
    func setupSearchBar() {
        countrySearchBar.barTintColor = .darkSeaGreen
        countrySearchBar.setIconColor(.white)
        countrySearchBar.setPlaceholderColor(.white)
        countrySearchBar.setTextColor(.white)
        countrySearchBar.layer.cornerRadius = 10
        countrySearchBar.layer.borderColor = UIColor.black.cgColor
        countrySearchBar.layer.borderWidth = 2
        countrySearchBar.layer.masksToBounds = true
    }
    
    func setupTableView() {
        countryTableView.backgroundColor = UIColor.darkSeaGreen
        countryTableView.layer.cornerRadius = 10
        countryTableView.layer.borderColor = UIColor.black.cgColor
        countryTableView.layer.borderWidth = 2
        countryTableView.layer.masksToBounds = true
    }
}
