//
//  WebViewCoordinator.swift
//  CountryInfo
//
//  Created by João Rouxinol on 23/07/2023.
//

import Foundation
import UIKit

class WebViewCoordinator {
    var socialType: SocialType
    
    public init(socialType: SocialType) {
        self.socialType = socialType
    }
    
    func start() -> UIViewController {
        let vc = WebViewViewController()
        vc.social = socialType
        return vc
    }
}
