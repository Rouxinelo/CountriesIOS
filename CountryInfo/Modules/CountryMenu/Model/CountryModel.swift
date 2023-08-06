//
//  CountryModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import Foundation

struct CountryModel: Codable {
    var name: Name
    var currencies: [String : Currency]?
    var continents: [String]
    var population: Double
    var borders: [String]?
    var area: Double
    var capital: [String]?
    var flags: Flag
    var cca3: String
    var latlng: [Double]
}

struct Name: Codable {
    var common: String
    var official: String
}

struct Currency: Codable {
    var name: String
}

struct Flag: Codable {
    var png: String
}
