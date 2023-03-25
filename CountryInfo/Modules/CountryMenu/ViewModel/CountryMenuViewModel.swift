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
    var subject: PassthroughSubject<[CountryModel], Never> { get }
}

class CountryMenuViewModel: CountryMenuViewModelProtocol {
    
    var subject = PassthroughSubject<[CountryModel], Never>()
    
    init(networkLayer: CountryMenuNetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
    
    // MARK: Variables
    var networkLayer: CountryMenuNetworkLayerProtocol
    var countries: [CountryModel]? {
        didSet {
            guard let countries = countries else { return }
            subject.send(countries)
        }
    }
    
    func getCountryData() {
        networkLayer.fetchData { success, data in
            if success {
                self.countries = data
            }
        }
    }
}
