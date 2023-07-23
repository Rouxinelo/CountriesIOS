//
//  AboutAppCoordinator.swift
//  CountryInfo
//
//  Created by João Rouxinol on 23/07/2023.
//

import Foundation
import UIKit

class AboutAppCoordinator: ModuleCoordinator {
    func start() -> UIViewController {
        let vc = AboutAppViewController()
        vc.viewModel = AboutAppViewModel()
        return vc
    }
}
