//
//  AboutAppViewController.swift
//  CountryInfo
//
//  Created by João Rouxinol on 23/07/2023.
//

import UIKit

class AboutAppViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var socialsLabel: UILabel!
    
    // MARK: Variables
    var viewModel: AboutAppViewModelProtocol?
    
    // MARK: SocialButtonsConfiguration
    
    func getSocialButton(tag: Int) -> UIButton {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 75, height: 75)))
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.tag = tag
        return button
    }
    
    func getButtonImage(imagePath: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: imagePath))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func getSocialButton(imagePath: String, tag: Int) -> UIButton {
        let button = getSocialButton(tag: tag)
        let imageView = getButtonImage(imagePath: imagePath)
        imageView.frame = button.bounds
        button.addSubview(imageView)
        button.addTarget(self, action: #selector(goToWebview(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate(
            [button.heightAnchor.constraint(equalToConstant: 75),
             button.widthAnchor.constraint(equalToConstant: 75)])
        return button
    }
    
    func getButtons() -> [UIButton] {
        [getSocialButton(imagePath: "linkedin", tag: 1),
         getSocialButton(imagePath: "github", tag: 2),
         getSocialButton(imagePath: "instagram", tag: 3)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
    }
    
    @objc func goToWebview(_ sender: UIButton) {
        guard let navigationController = navigationController else { return }
        viewModel?.goToWebview(tag: sender.tag, navigationController: navigationController)
    }
    
    func setStyle() {
        contentView.backgroundColor = .lightSeaGreen
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
        socialsLabel.textColor = .white
        descriptionLabel.text = AboutAppStrings.description
        for button in getButtons() {
            buttonsStackView.addArrangedSubview(button)
        }
    }
}
