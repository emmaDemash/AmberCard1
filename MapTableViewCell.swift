//
//  MapTableViewCell.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 19.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import UIKit


class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: YMKMapView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
