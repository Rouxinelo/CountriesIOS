//
//  CountryMenuViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import Foundation

protocol CountryMenuViewModelProtocol {
    func getCountryData()
    
}
class CountryMenuViewModel: CountryMenuViewModelProtocol {
    
    init(networkLayer: CountryMenuNetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
    
    // MARK: Variables
    var networkLayer: CountryMenuNetworkLayerProtocol
    
    func getCountryData() {
        networkLayer.fetchData { success, data in
            if success {
                print(data)
            } else {
                print("error")
            }
        }
    }
}
