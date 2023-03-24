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
    }
    
    func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor.lightSeaGreen
    }
}
