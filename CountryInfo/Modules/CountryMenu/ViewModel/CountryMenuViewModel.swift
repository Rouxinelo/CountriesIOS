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
    var subject: PassthroughSubject<[String : [CountryModel]], Never> { get }
}

class CountryMenuViewModel: CountryMenuViewModelProtocol {
    
    var subject = PassthroughSubject<[String : [CountryModel]], Never>()
    
    init(networkLayer: CountryMenuNetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
    
    // MARK: Variables
    var networkLayer: CountryMenuNetworkLayerProtocol
    var countries: [String : [CountryModel]]? {
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
    
    func filterByContinent(countries: [CountryModel]) -> [String : [CountryModel]] {
        var continents: [String] = []
        var orderedCountries: [String : [CountryModel]] = [:]
        for country in countries {
            if let continent = country.continents.first, !continents.contains(continent) {
                continents.append(continent)
            }
        }
        for continent in continents {
            let country = countries.filter { $0.continents.first == continent }
            orderedCountries[continent] = country
        }
        
        return orderedCountries
    }
}
