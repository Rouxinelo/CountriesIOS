//
//  WebViewViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 23/07/2023.
//

import UIKit
import WebKit

enum SocialType: String {
    case instagram
    case github
    case linkedin
}
class WebViewViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var webview: WKWebView!
    
    // MARK: Variables
    var social: SocialType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWebsite()
        loadTitle()
    }
    
    func setupView() {
        view.backgroundColor = .lightSeaGreen
    }
    
    func loadTitle() {
        if let social = social, let navBar = navigationController?.navigationBar {
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            title = social.rawValue.capitalized
        }
    }
    
    func loadWebsite() {
        guard let social = social, let urlString = getURLFromSocialType(social) else { return }
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
    
    func getURLFromSocialType(_ socialType: SocialType) -> String? {
        switch socialType {
        case .github:
            return WebviewLinks.githubLink
        case .instagram:
            return WebviewLinks.instagramLink
        case .linkedin:
            return WebviewLinks.linkedinLink
        }
    }
}
