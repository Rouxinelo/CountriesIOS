//
//  CountryRepresentable.swift
//  CountryInfo
//
//  Created by João Rouxinol on 15/07/2023.
//

import Foundation

struct CountryRepresentable {
    var name: Name
    var currencies: [String : Currency]?
    var continents: [String]
    var population: Double
    var borders: [String : String]?
    var area: Double
    var capital: [String]?
    var flags: Flag
    var latitude: Double
    var longitude: Double
}

