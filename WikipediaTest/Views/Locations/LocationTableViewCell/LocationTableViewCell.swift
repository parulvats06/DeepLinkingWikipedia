//
//  LocationTableViewCell.swift
//  WikipediaTest
//
//  Created by Parul Vats on 13/07/2020.
//  Copyright © 2020 Tekhsters. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    //MARK: - IBOutlets
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationCoordinateLabel: UILabel! {
        didSet {
            locationCoordinateLabel.textColor = .darkGray
        }
    }
    
    //MARK: - Variables
    var location: Location? {
        didSet {
            if let location = self.location {
                configureCell(location)
            }
        }
    }
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Private methods
    private func configureCell(_ location: Location) {
        self.locationTitleLabel.text = location.title
        self.locationCoordinateLabel.text = "Lat: " + location.latitude + ", Long: " + location.longitude
    }
}
