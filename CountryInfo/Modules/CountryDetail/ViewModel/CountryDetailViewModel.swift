//
//  CountryDetailViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 08/07/2023.
//

import Foundation
import Combine

protocol CountryDetailViewModelProtocol {
    func parseDetailSections(countryInfo: CountryModel)
    func getCountryInfo()
    var detailSubject: PassthroughSubject<[DetailSection], Never> { get }
    var countrySubject: PassthroughSubject<CountryModel, Never> { get }
}

class CountryDetailViewModel: CountryDetailViewModelProtocol {
    var country: CountryModel
    var detailSubject = PassthroughSubject<[DetailSection], Never>()
    var countrySubject = PassthroughSubject<CountryModel, Never>()

    public init(country: CountryModel) {
        self.country = country
    }
    
    func getCountryInfo() {
        countrySubject.send(country)
        parseDetailSections(countryInfo: country)
    }
    
    func parseDetailSections(countryInfo: CountryModel) {
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
            details.append(DetailSection(sectionTitle: .borders, sectionInfo: borders.joined(separator: " ")))
        }
        
        detailSubject.send(details)
    }
    
}
