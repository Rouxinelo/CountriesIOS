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
    var countries: FilteredCountries?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindCountriesRecieved()
        defineSwipeGesture()
        registerCell()
        countryTableView.dataSource = self
        countryTableView.delegate = self
        countrySearchBar.delegate = self
        setupViews()
        
        if let viewModel = viewModel {
            viewModel.getCountryData()
        }
    }

    // MARK: Navigation
    
    func defineSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(goBack))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func goBack() {
        guard let navigationController = navigationController, let viewModel = viewModel else { return }
        viewModel.goBack(navigationController: navigationController)
    }
    
    // MARK: Combine Binding
    
    func bindCountriesRecieved() {
        guard let viewModel = viewModel else { return }
        
        viewModel.subject.sink { countries in
            self.countries = countries
            self.setupData()
        }.store(in: &subscription)
    }
    
    func setupData() {
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
        }
    }
    
    // MARK: View Configuration
    
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

// MARK: TableView Logic

extension CountryMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell() {
        countryTableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countries = countries else { return 0 }
        return hiddenSections.contains(buildSectionTitleString(countryData: countries, section: section)) ? 0 : countries.countriesPerContinent[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell, let countries = countries else { return UITableViewCell() }
        cell.configureCell(countryInfo: countries.countriesPerContinent[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries?.continent.count ?? 0
    }

    
    // MARK: - Headers logic
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let countries = countries else { return nil }
        let sectionButton = UIButton()
        sectionButton.setTitle(buildSectionTitleString(countryData: countries, section: section), for: .normal)
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
    
    func buildSectionTitleString(countryData: FilteredCountries, section: Int) -> String {
        return "\(countryData.continent[section]) (\(countryData.countriesPerContinent[section].count))"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        
        let vc = CountryDetailCoordinator().start()
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: SearchBar Logic

extension CountryMenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.textDidChange(text: searchText)
    }
}
