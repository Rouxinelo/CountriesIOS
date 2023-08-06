//
//  DetailSection.swift
//  CountryInfo
//
//  Created by João Rouxinol on 11/04/2023.
//

import Foundation

enum Section {
    case location
    case currency
    case continent
    case population
    case area
    case capital
    case borders
}

extension Section {
    var title: String {
        switch self {
        case .location:
            return "Location:"
        case .area:
            return "Area:"
        case .borders:
            return "Borders:"
        case .capital:
            return "Capital:"
        case .continent:
            return "Continent:"
        case .currency:
            return "Currency:"
        case .population:
            return "Population:"
        }
    }
}
struct DetailSection {
    var sectionTitle: Section
    var sectionInfo: String
    var borders: [String: String]?
    var coordinates: [Double]?
}
