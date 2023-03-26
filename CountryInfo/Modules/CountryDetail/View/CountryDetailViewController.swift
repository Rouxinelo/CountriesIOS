//
//  CountryDetailViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 26/03/2023.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        // Do any additional setup after loading the view.
    }
    
    func configureViews() {
        backgroundView.backgroundColor = .lightSeaGreen
    }
}
