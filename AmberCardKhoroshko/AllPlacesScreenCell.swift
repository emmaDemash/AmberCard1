//
//  AllPlacesScreenCell.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 16.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import UIKit

class AllPlacesScreenCell: UITableViewCell {
    
    static let shared = AllPlacesScreenCell()    
    
    @IBOutlet weak var placeTypeIcon: UIImageView!
    
    @IBOutlet weak var placeTypeLabel: UILabel!

    @IBOutlet weak var placeName: UILabel!

    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var metersToDestination: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var discountIcon: UIImageView!

    @IBOutlet weak var discountLabel: UILabel!

    
    func setFonts () {
        placeDescription.font = UIFont.acTextStyleFont()
        placeName.font = UIFont.acH1Font()
    }
    
    
    
    
}
