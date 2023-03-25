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
}
