//
//  AboutAppViewModel.swift
//  CountryInfo
//
//  Created by João Rouxinol on 23/07/2023.
//

import Foundation
import UIKit

protocol AboutAppViewModelProtocol {
    func goToWebview(tag: Int, navigationController: UINavigationController)
}

class AboutAppViewModel: AboutAppViewModelProtocol {
    func goToWebview(tag: Int, navigationController: UINavigationController) {
        switch tag {
        case 1:
            let vc = WebViewCoordinator(socialType: .linkedin).start()
            navigationController.pushViewController(vc, animated: true)
        case 2:
            let vc = WebViewCoordinator(socialType: .github).start()
            navigationController.pushViewController(vc, animated: true)
        case 3:
            let vc = WebViewCoordinator(socialType: .instagram).start()
            navigationController.pushViewController(vc, animated: true)
        default:
            print("goNowhere")
        }
    }
}
