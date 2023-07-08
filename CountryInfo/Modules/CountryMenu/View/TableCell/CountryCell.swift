//
//  CountryCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var cellContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        cellContentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        cellContentView.layer.borderWidth = 2
        cellContentView.layer.borderColor = UIColor.black.cgColor
        cellContentView.layer.masksToBounds = true
        cellContentView.layer.cornerRadius = 10
        flagImage.layer.cornerRadius = flagImage.frame.width / 2
        flagImage.layer.masksToBounds = true
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.black.cgColor
        flagImage.backgroundColor = .lightGray
        selectionStyle = .none
    }
    
    func configureCell(countryInfo: CountryModel) {
        nameLabel.text = countryInfo.name.common
        capitalLabel.text = countryInfo.capital?.first ?? "Not available"
        populationLabel.text = formatPopulation(population: countryInfo.population)
        
        if let imageURL = URL(string: countryInfo.flags.png) {
            flagImage.load(url: imageURL)
        } else {
            flagImage.image = UIImage(named: "noFlag")
        }

    }
}
