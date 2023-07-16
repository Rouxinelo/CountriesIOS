//
//  BorderCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 15/07/2023.
//

import UIKit

class BorderCell: UITableViewCell {

    @IBOutlet weak var sectionTitleContentView: UIView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var borderCollectionView: UICollectionView!
    
    var countries: [String]?
    var borders: [String: String]? {
        didSet {
            guard let borders = borders else { return }
            countries = Array(borders.keys)
            borderCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        borderCollectionView.dataSource = self
        borderCollectionView.delegate = self
        registerCell()
        setStyle()
        setupViews()
        borderCollectionView.reloadData()
    }
    
    func setStyle() {
        sectionTitle.textColor = .black
        sectionTitle.backgroundColor = .clear
        sectionTitle.backgroundColor = .backgroundWhite
        sectionTitle.layer.borderColor = UIColor.black.cgColor
        sectionTitle.layer.borderWidth = 2
    }
    
    func setupViews() {
        backgroundColor = .clear
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .darkSeaGreen
    }
    
    func configureCell(detailSection: DetailSection) {
        sectionTitle.text = detailSection.sectionTitle.title
    }
}

extension BorderCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func registerCell() {
        borderCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return borders?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let borders = borders,
                let countries = countries,
                let cell = borderCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell() }
        
        let country = countries[indexPath.row]
        cell.setupCell(name: country, imgURL: borders[country] ?? "")
        return cell
    }
}
