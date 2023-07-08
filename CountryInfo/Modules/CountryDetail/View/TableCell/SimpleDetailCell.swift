//
//  SimpleDetailCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 11/04/2023.
//

import UIKit

class SimpleDetailCell: UITableViewCell {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var sectionDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    func setupViews() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    func configureCell(detailSection: DetailSection) {
        sectionTitle.text = detailSection.sectionTitle.title
        sectionDescription.text = detailSection.sectionInfo
    }
    
}
