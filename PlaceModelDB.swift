//
//  PlaceModelDB.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 16.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class PlaceModel: Object, Mappable{
    
    dynamic var id : Int = 0
    dynamic var name : String?
    //  dynamic var category_id : RLMArray<Int>?
    dynamic var description_text : String?
    dynamic var description_2 : String?
    dynamic var latitude : Double = 0.0
    dynamic var longitude : Double = 0.0
    // dynamic var rate : String?
    dynamic var cost_sum : String?
    dynamic var cost_text : String?
    dynamic var phone : String?
    dynamic var site : String?
    dynamic var discount_min : String?
    dynamic var discount_max : String?
    dynamic var discount_conditions : String?
    dynamic var min_people : String?
    dynamic var max_people : String?
    //  dynamic var photos : Array<String>?
    
    
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    dynamic var category: PlacesCategories!
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id   <- map["id"]
        name <- map["name"]
        description_text <- map["description_text"]
        latitude <- map["latitude"]
        longitude    <- map["longitude"]
        description_2 <- map["description_2"]
        phone <- map["phone"]
        cost_sum <- map["cost_sum"]
        cost_text    <- map["cost_text"]
        phone <- map["phone"]
        site <- map["site"]
        discount_min <- map["discount_min"]
        discount_max    <- map["discount_max"]
        discount_conditions <- map["discount_conditions"]
        min_people <- map["min_people"]
        max_people <- map["max_people"]
        
    }
    
}
