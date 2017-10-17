//
//  PlacePhotos.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 17.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class PhotosModel: Object, Mappable{

    dynamic var place_id : Int = 0
    dynamic var photo : String?
    
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        
        place_id   <- map["id"]
        photo <- map["photos"]
    }
}
