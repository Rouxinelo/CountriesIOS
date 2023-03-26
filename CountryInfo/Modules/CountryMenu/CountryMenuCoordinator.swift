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
}

class CountryMenuCoordinator: ModuleCoordinator, CountryMenuCoordinatorProtocol {
    func start() -> UIViewController {
        let vc = CountryMenuViewController()
        vc.viewModel = CountryMenuViewModel(networkLayer: CountryMenuNetworkLayer(), coordinator: self)
        return vc
    }
    
    func goBack(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
