//
//  MainMenuViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 16/03/2023.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var globeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

    // MARK: View setup
    
    func setupViews() {
        backgroundView.backgroundColor = UIColor.lightSeaGreen
        setupStartButton()
        setupTitle()
        setupDescription()
        setupAbout()
        setupImage()
    }
    
    func setupStartButton() {
        startButton.setTitle("Try WorldFinder!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.darkSeaGreen
        startButton.layer.cornerRadius = 10
    }
    
    func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.text = "Discover\nthe world."
    }
    
    func setupDescription() {
        descriptionLabel.textColor = .white
        descriptionLabel.text = "Find out more about all the countries in the world."
    }
    
    func setupAbout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "About the app ", style: .plain, target: self, action: #selector(goToAbout))
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupImage() {
        globeImage.image = UIImage(named: "globe")
    }
    
    // MARK: Navigation
    
    @IBAction func goToCountryMenu(_ sender: Any) {
        if let navigationController = self.navigationController {
            let vc = CountryMenuCoordinator().start()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    @objc func goToAbout() {
    }
}
