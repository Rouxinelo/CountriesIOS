//
//  MapCell.swift
//  CountryInfo
//
//  Created by João Rouxinol on 06/08/2023.
//

import UIKit
import MapKit

class MapCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        setupTitleLabel()
    }
    
    func setupCell() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.masksToBounds = true
        titleView.layer.borderColor = UIColor.black.cgColor
        titleView.layer.borderWidth = 2
        titleView.backgroundColor = .backgroundWhite
        contentView.backgroundColor = .darkSeaGreen
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Location:"
    }
}

extension MapCell: MKMapViewDelegate {
    func setCoordinates(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude, let longitude = longitude else { return }
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: false)
    }
}
