//
//  MainMenuViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 16/03/2023.
//

import Foundation
import UIKit

protocol MainMenuViewModelProtocol {
    func goToCountryMenu(navigationController: UINavigationController)
    func goToAboutScreen(navigationController: UINavigationController)
}

class MainMenuViewModel: MainMenuViewModelProtocol {
    func goToCountryMenu(navigationController: UINavigationController) {
        let vc = CountryMenuCoordinator().start()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAboutScreen(navigationController: UINavigationController) {
        let vc = AboutAppCoordinator().start()
        navigationController.pushViewController(vc, animated: true)
    }
}
