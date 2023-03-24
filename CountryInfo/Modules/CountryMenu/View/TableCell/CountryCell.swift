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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        flagImage.image = UIImage(named: "globe")
        nameLabel.text = "Portugal"
        capitalLabel.text = "Lisboa"
        populationLabel.text = "10 Milion"
    }
}
