//
//  CountryDetailViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 26/03/2023.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var countryImage: UIImageView!
    
    var country: CountryModel?
    var detailSections: [DetailSection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        detailTableView.dataSource = self
        configureViews()
    }
    
    func configureViews() {
        backgroundView.backgroundColor = .lightSeaGreen
        countryImage.backgroundColor = .lightGray
        countryImage.layer.borderColor = UIColor.black.cgColor
        countryImage.layer.borderWidth = 2
        countryImage.layer.cornerRadius = 10
        setCountry()
    }
    
    func setCountry() {
        guard let country = country, let url = URL(string: country.flags.png) else { return }
        countryImage.load(url: url)
        setTitle(countryName: country.name.common)
        setDetailArray()
        detailTableView.reloadData()
    }
    
    func setTitle(countryName: String) {
        if let navBar = navigationController?.navigationBar {
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        title = countryName
    }
    
    func setDetailArray() {
        guard let country = country else { return }
        
        var details: [DetailSection] = []
        
        if let currency = country.currencies?.first {
            details.append(DetailSection(sectionTitle: .currency, sectionInfo: currency.value.name))
        }
        
        if let continent = country.continents.first {
            details.append(DetailSection(sectionTitle: .continent, sectionInfo: continent))
        }
        
        details.append(DetailSection(sectionTitle: .population, sectionInfo: String(country.population)))
        
        if let borders = country.borders {
            details.append(DetailSection(sectionTitle: .borders, sectionInfo: borders.joined(separator: " ")))
        }
        
        details.append(DetailSection(sectionTitle: .area, sectionInfo: String(country.area)))
        
        if let capital = country.capital?.first {
            details.append(DetailSection(sectionTitle: .capital, sectionInfo: capital))
        }
        
        detailSections = details
    }
}

extension CountryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell() {
        detailTableView.register(UINib(nibName: "SimpleDetailCell", bundle: nil), forCellReuseIdentifier: "SimpleDetailCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleDetailCell", for: indexPath) as? SimpleDetailCell, let detailSections = detailSections else { return UITableViewCell() }
        
        cell.configureCell(detailSection: detailSections[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailSections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sections = detailSections, sections[indexPath.row].sectionTitle == .borders {
            // Handle showing info
        }
    }
}
