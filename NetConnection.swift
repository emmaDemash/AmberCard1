//
//  NetConnection.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 13.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import Foundation
import Alamofire

class NetConnection {
    
var placeNC = Place()

//func createConnection () -> Place{
//    
//    Alamofire.request("https://api.myjson.com/bins/1gizl5").responseJSON { response in
//        print("Request: \(String(describing: response.request))")
//        print("Response: \(String(describing: response.response))") // http url response
//        print("Result: \(response.result)")                         // response serialization result
//        
//        if let json = response.result.value {
//            
//            
//            if let jsondata = json as? [String: Any],
//                let name = jsondata["name"] as? String,
//                let description = jsondata["description"] as? String,
//                let description_2 = jsondata["description_2"] as? String,
//                let cost_text = jsondata["cost_text"] as? String,
//                let cost_sum = jsondata["cost_sum"] as? String,
//                let longitude = jsondata["longitude"] as? Double,
//                let latitude = jsondata["latitude"] as? Double,
//                let phone = jsondata["phone"] as? String,
//                let photos = jsondata["photos"] as? NSArray,
//                let category_id = jsondata["category_id"] as? [[String: Any]],
//                let icon = category_id[0]["icon"] as? String,
//                let typeName = category_id[0]["name"] as? String,
//                let picture = category_id[0]["picture"] as? String{
//                
//                self.place.name = name
//                self.place.costInfo = ("\(cost_text): \(cost_sum) рублей")
//                self.place.description = description
//                self.place.latitude = latitude
//                self.place.latitude = longitude
//                self.place.phoneNumber = phone
//                self.place.images = photos as! [String]
//                self.place.workHours = description_2
//                self.place.typeIcon = icon
//                self.place.placeType = typeName
//                self.place.placeMainImg = picture
//                
//            }
//        }
//    }
 // }
}
