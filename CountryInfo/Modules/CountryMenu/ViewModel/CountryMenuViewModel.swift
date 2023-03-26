//
//  CountryMenuViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import Foundation
import Combine

protocol CountryMenuViewModelProtocol {
    func getCountryData()
    func textDidChange(text: String)
    var subject: PassthroughSubject<FilteredCountries, Never> { get }
}

class CountryMenuViewModel: CountryMenuViewModelProtocol {
    
    var subject = PassthroughSubject<FilteredCountries, Never>()
    
    init(networkLayer: CountryMenuNetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
    
    // MARK: Variables
    var networkLayer: CountryMenuNetworkLayerProtocol
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
        var continents: [String] = []
        var orderedCountries: [[CountryModel]] = []
        for country in countries {
            if let continent = country.continents.first, !continents.contains(continent) {
                continents.append(continent)
            }
        }
        for continent in continents {
            let country = countries.filter { $0.continents.first == continent }
            orderedCountries.append(country.sorted { $0.name.common < $1.name.common })
        }
        
        return FilteredCountries(countriesPerContinent: orderedCountries, continent: continents)
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
}
