//
//  CountryDetailCoordinator.swift
//  CountryInfo
//
//  Created by João Rouxinol on 26/03/2023.
//

import Foundation
import UIKit
class CountryDetailCoordinator: ModuleCoordinator {
    func start() -> UIViewController {
        let vc = CountryMenuViewController()
        vc.viewModel = CountryMenuViewModel(networkLayer: CountryMenuNetworkLayer(), coordinator: self)
        return vc
    }
}
