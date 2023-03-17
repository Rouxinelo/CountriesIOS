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
    @IBOutlet weak var mainMenuImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

    func setupViews() {
        backgroundView.backgroundColor = UIColor.lightSeaGreen
        setupStartButton()
        setupImage()
        setupTitle()
        setupDescription()
        setupAbout()
    }
    
    func setupStartButton() {
        startButton.setTitle("Try WorldFinder!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.darkSeaGreen
        startButton.layer.cornerRadius = 10
    }
    
    func setupImage() {
        mainMenuImage.image = UIImage(named: "globe")
    }
    
    func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.text = "Discover the world."
    }
    
    func setupDescription() {
        descriptionLabel.textColor = .white
        descriptionLabel.text = "Find out more about all the countries in the world."
    }
    
    func setupAbout() {
        aboutLabel.textColor = .white
        aboutLabel.text = "about the app >"
    }
}
