//
//  CustomDescriptionPlaceCell.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 12.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import UIKit

class CustomDescriptionPlaceCell: UITableViewCell {

    
     @IBOutlet weak var placeTypeIcon: UIImageView!
     @IBOutlet weak var placeType: UILabel!
     @IBOutlet weak var placeName: UILabel!
     @IBOutlet weak var placeDescription: UILabel!
     @IBOutlet weak var placeWorkingHours: UILabel!
     @IBOutlet weak var placeCostDetails: UILabel!



//    func CellHeight(text: NSString?) -> CGFloat {
//        
//        var offset = 1.7
//        var font  = UIFont.systemFont(ofSize: 17)
//        var paragraph = NSMutableParagraphStyle
//        paragraph
//        
//        NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init]
//        [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
//        
//        NSDictionary* attributes =
//        [NSDictionary dictionaryWithObjectsAndKeys:
//        font , NSFontAttributeName,
//        paragraph, NSParagraphStyleAttributeName, nil];
//        
//        CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
//        
//        return CGRectGetHeight(rect) + 2 * offset;
//        
//    }
}
