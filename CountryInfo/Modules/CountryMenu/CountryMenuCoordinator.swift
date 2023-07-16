//
//  CountryMenuCoordinator.swift
//  CountryInfo
//
//  Created by João Rouxinol on 17/03/2023.
//

import Foundation
import UIKit

protocol CountryMenuCoordinatorProtocol {
    func goBack(navigationController: UINavigationController)
    func goToDetail(navigationController: UINavigationController, countryRepresentable: CountryRepresentable)
}

class CountryMenuCoordinator: ModuleCoordinator, CountryMenuCoordinatorProtocol {
    func goToDetail(navigationController: UINavigationController, countryRepresentable: CountryRepresentable) {
        let coord = CountryDetailCoordinator()
        coord.country = countryRepresentable
        let vc = coord.start()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func start() -> UIViewController {
        let vc = CountryMenuViewController()
        vc.viewModel = CountryMenuViewModel(networkLayer: CountryMenuNetworkLayer(), coordinator: self)
        return vc
    }
    
    func goBack(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
