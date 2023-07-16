//
//  CollectionViewCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 15/07/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }

    func setupCell(name: String, imgURL: String) {
        guard let url = URL(string: imgURL) else { return }
        titleLabel.text = name
        flagImage.load(url: url)
    }
    
    func setStyle() {
        titleLabel.textColor = .black
        flagImage.layer.cornerRadius = 10
        flagImage.layer.borderColor = UIColor.black.cgColor
        flagImage.layer.borderWidth = 2
        borderView.backgroundColor = .backgroundWhite
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 2
    }
}
