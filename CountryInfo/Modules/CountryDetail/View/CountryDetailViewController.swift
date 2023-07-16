//
//  CountryDetailViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 26/03/2023.
//

import UIKit
import Combine

class CountryDetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var countryImage: UIImageView!
    
    // MARK: Variables
    var detailSections: [DetailSection]? {
        didSet {
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
    var viewModel: CountryDetailViewModelProtocol?
    var subscription = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel?.getCountryInfo()
        registerCell()
        detailTableView.dataSource = self
        detailTableView.delegate = self
        configureViews()
    }
    
    func configureViews() {
        backgroundView.backgroundColor = .lightSeaGreen
        countryImage.backgroundColor = .lightGray
        countryImage.layer.borderColor = UIColor.black.cgColor
        countryImage.layer.borderWidth = 2
        countryImage.layer.cornerRadius = 10
    }
    
    func setCountry(country: CountryRepresentable) {
        guard let url = URL(string: country.flags.png) else { return }
        countryImage.load(url: url)
        setTitle(countryName: country.name.common)
        detailTableView.reloadData()
    }
    
    func setTitle(countryName: String) {
        if let navBar = navigationController?.navigationBar {
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        title = countryName
    }
    
    // MARK: Combine Bindings
    func bind() {
        subscribeCountryRecieved()
        subscribeDetailSectionsRecieved()
    }
    
    func subscribeCountryRecieved() {
        viewModel?.countrySubject.sink { country in
            self.setCountry(country: country)
        }.store(in: &subscription)
    }
    
    func subscribeDetailSectionsRecieved() {
        viewModel?.detailSubject.sink { details in
            self.detailSections = details
        }.store(in: &subscription)
    }
}

extension CountryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell() {
        detailTableView.register(UINib(nibName: "SimpleDetailCell", bundle: nil), forCellReuseIdentifier: "SimpleDetailCell")
        detailTableView.register(UINib(nibName: "BorderCell", bundle: nil), forCellReuseIdentifier: "BorderCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detailSections = detailSections else { return UITableViewCell() }
        switch detailSections[indexPath.row].sectionTitle {
        case .borders:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BorderCell", for: indexPath) as? BorderCell
            else { return UITableViewCell() }
            cell.borders = detailSections[indexPath.row].borders
            cell.configureCell(detailSection: detailSections[indexPath.row])
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleDetailCell", for: indexPath) as? SimpleDetailCell
            else { return UITableViewCell() }
            cell.configureCell(detailSection: detailSections[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailSections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sections = detailSections else { return UITableView.automaticDimension }
        switch sections[indexPath.row].sectionTitle {
        case .borders:
            return 200
        default:
            return 100
        }
    }
}
