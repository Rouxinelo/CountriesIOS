//
//  SimpleDetailCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 11/04/2023.
//

import UIKit

class SimpleDetailCell: UITableViewCell {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var sectionTitleContentView: UIView!
    @IBOutlet weak var sectionDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }

    func setupViews() {
        backgroundColor = .clear
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .darkSeaGreen
    }
    
    func setupLabels() {
        sectionTitle.textColor = .black
        sectionTitle.backgroundColor = .clear
        sectionTitleContentView.backgroundColor = .backgroundWhite
        sectionTitleContentView.layer.borderColor = UIColor.black.cgColor
        sectionTitleContentView.layer.borderWidth = 2
        sectionDescription.textColor = .white

    }
    
    func configureCell(detailSection: DetailSection) {
        sectionTitle.text = detailSection.sectionTitle.title
        sectionDescription.text = detailSection.sectionInfo
    }
    
}
