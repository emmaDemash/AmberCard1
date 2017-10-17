//
//  PlacesCaregories.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 16.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.

import Foundation
import RealmSwift
import ObjectMapper


public class PlacesCategories: Object, Mappable {
    
     var id : Int?
     var name : String?
     var icon : String?
     var picture : String?
    
    
    required convenience public init?(map: Map) {
        self.init()
        
    }
    
    public func mapping(map: Map) {
        id   <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        picture <- map["picture"]
    }
}
