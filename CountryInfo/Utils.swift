//
//  Utils.swift
//  CountryInfo
//
//  Created by João Rouxinol on 26/03/2023.
//

import Foundation

func buildSectionTitleString(countryData: FilteredCountries, section: Int) -> String {
    return "\(countryData.continent[section]) (\(countryData.countriesPerContinent[section].count))"
}

func formatPopulation(population: Double) -> String {
    switch population {
    case .thousand ..< .million:
        return "\(String(format: "%.1f", population / .thousand)) Thousand"
    case .million ..< .billion:
        return "\(String(format: "%.1f", population / .million)) Million"
    case .billion ..< .trillion:
        return "\(String(format: "%.1f", population / .billion)) Billion"
    default:
        return String(population)
    }
}
