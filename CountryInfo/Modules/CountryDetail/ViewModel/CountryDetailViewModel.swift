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
    // MARK: Variables
    var country: CountryRepresentable
    var detailSubject = PassthroughSubject<[DetailSection], Never>()
    var countrySubject = PassthroughSubject<CountryRepresentable, Never>()

    //MARK: Functions
    public init(country: CountryRepresentable) {
        self.country = country
    }
    
    func getCountryInfo() {
        countrySubject.send(country)
        parseDetailSections(countryInfo: country)
    }
    
    func parseDetailSections(countryInfo: CountryRepresentable) {
        var details: [DetailSection?] = []
        details.append(DetailSection(sectionTitle: .location, sectionInfo: "", coordinates: [countryInfo.latitude, countryInfo.longitude]))
        details.append(getDetailSection(sectionTitle: .currency, sectionInfo: countryInfo.currencies?.first?.value.name))
        details.append(getDetailSection(sectionTitle: .continent, sectionInfo: countryInfo.continents.first))
        details.append(getDetailSection(sectionTitle: .population, sectionInfo: formatPopulation(population: countryInfo.population)))
        details.append(getDetailSection(sectionTitle: .area, sectionInfo: formatArea(area: country.area)))
        details.append(getDetailSection(sectionTitle: .capital, sectionInfo: countryInfo.capital?.first))
        if let borders = countryInfo.borders {
            details.append(DetailSection(sectionTitle: .borders, sectionInfo: "", borders: borders))
        }
        detailSubject.send(details.compactMap{$0})
    }
    
    func getDetailSection(sectionTitle: Section, sectionInfo: String?) -> DetailSection? {
        guard let sectionInfo = sectionInfo else { return nil }
        return DetailSection(sectionTitle: sectionTitle, sectionInfo: sectionInfo)
    }
}
