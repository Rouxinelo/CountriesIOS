//
//  CollectionViewCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 15/07/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        titleLabel.textColor = .white
        flagImage.layer.cornerRadius = 10
    }
}
