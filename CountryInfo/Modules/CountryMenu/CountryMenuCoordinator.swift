//
//  CountryMenuCoordinator.swift
//  CountryInfo
//
//  Created by João Rouxinol on 17/03/2023.
//

import Foundation
import UIKit

class CountryMenuCoordinator: ModuleCoordinator {
    func start() -> UIViewController {
        let vc = CountryMenuViewController()
        vc.viewModel = CountryMenuViewModel(networkLayer: CountryMenuNetworkLayer())
        return vc
    }
}
