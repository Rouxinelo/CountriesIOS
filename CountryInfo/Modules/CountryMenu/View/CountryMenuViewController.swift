//
//  CountryMenuViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 17/03/2023.
//

import UIKit
import Combine

class CountryMenuViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    // MARK: Functions
    var hiddenSections = Set<String>()
    var viewModel: CountryMenuViewModelProtocol?
    var subscription = Set<AnyCancellable>()
    var countries: [CountryModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindCountriesRecieved()
        registerCell()
        countryTableView.dataSource = self
        countryTableView.delegate = self
        setupViews()
        
        if let viewModel = viewModel {
            viewModel.getCountryData()
        }
    }

    func bindCountriesRecieved() {
        guard let viewModel = viewModel else { return }
        
        viewModel.subject.sink { countries in
            print(countries)
            self.countries = countries
            self.setupData()
        }.store(in: &subscription)
    }
    
    func setupData() {
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
        }
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

extension CountryMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell() {
        countryTableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiddenSections.contains(String(section)) ? 0 : countries?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    // MARK: - Headers logic
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionButton = UIButton()
        sectionButton.setTitle(String(section), for: .normal)
        sectionButton.backgroundColor = .white
        sectionButton.tag = section
        sectionButton.layer.borderColor = UIColor.black.cgColor
        sectionButton.layer.borderWidth = 2
        sectionButton.setTitleColor(.black, for: .normal)
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)
        
        return sectionButton
    }
    
    @objc func hideSection(sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        if hiddenSections.contains(title) {
            hiddenSections.remove(title)
        } else {
            hiddenSections.insert(title)
        }
        countryTableView.reloadData()
    }
}
