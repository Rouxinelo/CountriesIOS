//
//  CountryDetailViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 08/07/2023.
//

import Foundation
import Combine

protocol CountryDetailViewModelProtocol {
    func parseDetailSections(countryInfo: CountryRepresentable)
    func getCountryInfo()
    var detailSubject: PassthroughSubject<[DetailSection], Never> { get }
    var countrySubject: PassthroughSubject<CountryRepresentable, Never> { get }
}

class CountryDetailViewModel: CountryDetailViewModelProtocol {
    var country: CountryRepresentable
    var detailSubject = PassthroughSubject<[DetailSection], Never>()
    var countrySubject = PassthroughSubject<CountryRepresentable, Never>()

    public init(country: CountryRepresentable) {
        self.country = country
    }
    
    func getCountryInfo() {
        countrySubject.send(country)
        parseDetailSections(countryInfo: country)
    }
    
    func parseDetailSections(countryInfo: CountryRepresentable) {
        var details: [DetailSection] = []
        
        if let currency = countryInfo.currencies?.first {
            details.append(DetailSection(sectionTitle: .currency, sectionInfo: currency.value.name))
        }
        
        if let continent = countryInfo.continents.first {
            details.append(DetailSection(sectionTitle: .continent, sectionInfo: continent))
        }
        
        details.append(DetailSection(sectionTitle: .population, sectionInfo: String(countryInfo.population)))
        
        details.append(DetailSection(sectionTitle: .area, sectionInfo: String(countryInfo.area)))
        
        if let capital = countryInfo.capital?.first {
            details.append(DetailSection(sectionTitle: .capital, sectionInfo: capital))
        }
        
        if let borders = countryInfo.borders {
            details.append(DetailSection(sectionTitle: .borders, sectionInfo: "", borders: borders))
        }
        
        detailSubject.send(details)
    }
    
}
