//
//  NetworkingService.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 17.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


typealias JSON = [String: Any]

class NetworkingService {
    
    let realm = try! Realm()
    
    static let shared = NetworkingService()
    private init() {}
    
    func getAllPlaces() {
        let headers: HTTPHeaders = [
            "Authorization": "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"
        ]
        
        
        Alamofire.request("http://138.68.68.166:9999/api/1/content", headers: headers).responseJSON { response in
            
            if let json = response.result.value {
                if let jsondata = json as? [String: Any] {
                    do {
                        print(jsondata)
                        try! self.realm.write() { // 2
                            
                            if let categoryDefaults = jsondata["categories"] as? [[String: Any]]
                            {
                                for category  in categoryDefaults {
                                    
                                    let newCategory = PlacesCategories()
                                    newCategory.icon = (category["icon"] as? String)!
                                    newCategory.name = (category["name"] as? String)!
                                    newCategory.id = (category["id"] as? Int)!
                                    newCategory.picture = (category["picture"] as? String)!
                                    print(newCategory)
                                    self.realm.add(newCategory)
                                }
                            }
                        }
                    }
                    do {
                        
                        try! self.realm.write() {
                            if let PointsDefaults = jsondata["points"] as? [[String: Any]]
                            {
                                for point in PointsDefaults { // 4
                                    let newPoint = PlaceModel()
                                    
                                    let photos =  point["photos"] as? [String]
                                    
                                    for picture in photos! {
                                        let photo = PhotosModel()
                                        photo.place_id = (point["id"] as? Int)!
                                        photo.photo = picture
                                        newPoint.photos.append(photo)
                                    }
                                    let categoryArray = point["category_id"] as? [Int]
                                    
                                    for item in categoryArray! {
                                        
                                        let category = LinkToCategory()
                                        category.value = item
                                        newPoint.category_id.append(category)
                                        //print(category)
                                        
                                    }
                                    
                                    newPoint.id = (point["id"] as? Int)!
                                    newPoint.name = point["name"] as? String
                                    newPoint.description_text = point["description"] as? String
                                    newPoint.description_2 = point["description_2"] as? String
                                    newPoint.latitude = (point["latitude"] as? Double)!
                                    newPoint.longitude = (point["longitude"] as? Double)!
                                    //  newPoint.rate = point["rate"] as? String
                                    newPoint.cost_sum = point["cost_sum"] as? String
                                    newPoint.cost_text = point["cost_text"] as? String
                                    newPoint.phone = point["phone"] as? String
                                    newPoint.site = point["site"] as? String
                                    newPoint.discount_min = point["discount_min"] as? String
                                    newPoint.discount_max = (point["discount_max"] as? String?)!
                                    newPoint.discount_conditions = point["discount_conditions"] as? String
                                    newPoint.min_people = point["min_people"] as? String
                                    newPoint.max_people = point["max_people"] as? String
                                    print(newPoint)
                                    self.realm.add(newPoint, update: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    //    func getHomeworld(homeworldLink: String, completion: @escaping (String) -> Void) {
    //        Alamofire.request(homeworldLink).responseJSON { (response) in
    //            guard let json = response.result.value as? JSON,
    //                let name = json["name"] as? String
    //                else { print("NOPE"); return }
    //            print("GOT HERE")
    //            completion(name)
    //   }
    //    }
}
