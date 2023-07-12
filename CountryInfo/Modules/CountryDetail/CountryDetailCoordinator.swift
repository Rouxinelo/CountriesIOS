//
//  CountryDetailCoordinator.swift
//  CountryInfo
//
//  Created by João Rouxinol on 26/03/2023.
//

import Foundation
import UIKit
class CountryDetailCoordinator: ModuleCoordinator {
    var country: CountryModel?
    var borders: [String : String]?
    
    func start() -> UIViewController {
        guard let country = country else { return UIViewController() }
        let vc = CountryDetailViewController()
        vc.viewModel = CountryDetailViewModel(country: country)
        return vc
    }
}
