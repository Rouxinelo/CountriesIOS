//
//  CountryMenuViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import Foundation
import Combine
import UIKit

protocol CountryMenuViewModelProtocol {
    func getCountryData()
    func textDidChange(text: String)
    func goBack(navigationController: UINavigationController)
    func getBorders(country: CountryModel) -> [String : String]
    func getRepresentableFromModel(borders: [String : String], country: CountryModel)
    func goToCountryDetail(navigationController: UINavigationController, countryRepresentable: CountryRepresentable)
    var subject: PassthroughSubject<FilteredCountries, Never> { get }
    var mappingSubject: PassthroughSubject<CountryRepresentable, Never> { get }
}

class CountryMenuViewModel: CountryMenuViewModelProtocol {
    var subject = PassthroughSubject<FilteredCountries, Never>()
    var mappingSubject = PassthroughSubject<CountryRepresentable, Never>()

    init(networkLayer: CountryMenuNetworkLayerProtocol, coordinator: CountryMenuCoordinatorProtocol) {
        self.networkLayer = networkLayer
        self.coordinator = coordinator
    }
    
    // MARK: Variables
    var networkLayer: CountryMenuNetworkLayerProtocol
    var coordinator: CountryMenuCoordinatorProtocol
    var countries: FilteredCountries? {
        didSet {
            guard let countries = countries else { return }
            subject.send(countries)
        }
    }
    
    func getCountryData() {
        networkLayer.fetchData { success, data in
            if success, let data = data {
                self.countries = self.filterByContinent(countries: data)
            }
        }
    }
    
    func filterByContinent(countries: [CountryModel]) -> FilteredCountries {
        var continents = Set<String>()
        var orderedCountries: [[CountryModel]] = []
        for country in countries {
            if let continent = country.continents.first {
                continents.insert(continent)
            }
        }
        for continent in continents {
            let country = countries.filter { $0.continents.first == continent }
            orderedCountries.append(country.sorted { $0.name.common < $1.name.common })
        }
        
        return FilteredCountries(countriesPerContinent: orderedCountries, continent: Array(continents))
    }
    
    func textDidChange(text: String) {
        guard let countries = countries else { return }
        
        if text.trimmingCharacters(in: .whitespaces) == "" {
            subject.send(countries)
        } else {
            var searchedCountries: [[CountryModel]] = []
            var continentsWithCountries: [String] = []
            
            for countries in countries.countriesPerContinent {
                let filteredCountries = countries.filter { $0.name.common.lowercased().contains(text.lowercased())}
                
                if let continent = filteredCountries.first?.continents.first, !filteredCountries.isEmpty {
                    searchedCountries.append(filteredCountries)
                    continentsWithCountries.append(continent)
                }
            }
            subject.send(FilteredCountries(countriesPerContinent: searchedCountries, continent: continentsWithCountries))
        }
    }
    
    func goBack(navigationController: UINavigationController) {
        coordinator.goBack(navigationController: navigationController)
    }
    
    func goToCountryDetail(navigationController: UINavigationController, countryRepresentable: CountryRepresentable) {
        coordinator.goToDetail(navigationController: navigationController, countryRepresentable: countryRepresentable)
    }
    
    func getBorders(country: CountryModel) -> [String : String] {
        guard let countries = countries, let borders = country.borders else { return [:] }
        let validBorders = countries.countriesPerContinent.flatMap({$0}).filter {borders.contains($0.cca3)}
        return validBorders.reduce(into: [:], {$0[$1.name.common] = $1.flags.png})
    }
    
    func getRepresentableFromModel(borders: [String : String], country: CountryModel) {
        var latitude: Double = 0
        var longitude: Double = 0
        if let lat = country.latlng.first, let lng = country.latlng.last {
            latitude = lat
            longitude = lng
        }
        let countryRepresentable = CountryRepresentable(name: country.name,
                                                        currencies: country.currencies,
                                                        continents: country.continents,
                                                        population: country.population,
                                                        borders: borders,
                                                        area: country.area,
                                                        capital: country.capital,
                                                        flags: country.flags,
                                                        latitude: latitude ,
                                                        longitude: longitude)
        mappingSubject.send(countryRepresentable)
    }
}
