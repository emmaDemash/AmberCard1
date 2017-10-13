//
//  PlaceViewController.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 12.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage



//ШРИФТЫ!


class PlaceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let baseURL = "http://138.68.68.166:9999"
    
    @IBOutlet weak var designView: UIView!
    @IBOutlet weak var tableViewPlaceInfo: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImage: UIImageView!
    var scrollOffset: CGPoint!
    
    
    struct cellData {
        let name: String!
        var image: UIImage!
    }
    
    var place = Place()
    
    
    var cellsArray = [cellData(name: "CustomDescriptionPlaceCell", image: #imageLiteral(resourceName: "defImg")),cellData(name: "BasicImgLblTVCellPhone", image: #imageLiteral(resourceName: "defImg")),cellData(name: "BasicImgLblTVCellAdress", image: #imageLiteral(resourceName: "defImg"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NetworkConnection()
        self.tableViewPlaceInfo.dataSource = self
        self.tableViewPlaceInfo.delegate = self
        self.designView.layer.cornerRadius = 8
        self.scrollView.delegate = self;
        //self.scrollView.contentSize.height = 8000
        scrollOffset = CGPoint.init(x: 0.0, y: 232) // скролл не готов y:высота фотки
        
        //        tableViewPlaceInfo.estimatedRowHeight = 72
        //        tableViewPlaceInfo.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
     self.tableViewPlaceInfo.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellsArray[indexPath.row].name {
            
        case "BasicImgLblTVCellPhone":
            let cell = Bundle.main.loadNibNamed("BasicImgLblTVCell", owner: self, options: nil)?.first as! BasicImgLblTVCell
            
            cell.cellText.text = place.phoneNumber
            
            //self.downloadIcon(place.typeIcon, "BasicImgLblTVCellPhone")
            
            let urlPath = ("\(baseURL)\(place.typeIcon)") //узнать откуда брать иконки для телефона и адреса
            
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.icon.image = imag
                }
            } // переделать позже
            return cell
            
        case "BasicImgLblTVCellAdress":
            let cell = Bundle.main.loadNibNamed("BasicImgLblTVCell", owner: self, options: nil)?.first as! BasicImgLblTVCell
            
            cell.cellText.text = ("тут должен быть адрес") // нет адреса в JSON
            // self.downloadIcon(place.typeIcon, "BasicImgLblTVCellAdress")
            
            let urlPath = ("\(baseURL)\(place.typeIcon)")
            
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.icon.image = imag
                }
            } // переделать позже
            return cell
            
        case "CustomDescriptionPlaceCell":
            let cell = Bundle.main.loadNibNamed("CustomDescriptionPlaceCell", owner: self, options: nil)?.first as! CustomDescriptionPlaceCell
            
           
            cell.placeType.text = place.placeType
            cell.placeName.text = place.name
            cell.placeDescription.text = place.description
            cell.placeCostDetails.text = place.costInfo
            cell.placeWorkingHours.text = place.workHours
            cell.placeType.text = place.placeType
            
            let urlPath = ("\(baseURL)\(place.typeIcon)")
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.placeTypeIcon.image = imag
                }
            } // переделать позже
            
            return cell
            
        default:
            let cell = Bundle.main.loadNibNamed("BasicImgLblTVCell", owner: self, options: nil)?.first as! BasicImgLblTVCell
            cell.textLabel?.text = "friend"
            
            let urlPath = ("\(baseURL)\(place.typeIcon)")
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.icon.image = imag
                }
            } // переделать позже
            
            return cell
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellsArray[indexPath.row].name {
        case "BasicImgLblTVCell":
            return 72
            
        case "CustomDescriptionPlaceCell":
            
            return 767 //как вычислить эту ячейку?
            
            
        default:
            return 72
        }
        
        
    }
    
    
    func NetworkConnection()  {
        
        Alamofire.request("https://api.myjson.com/bins/1gizl5").responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                
                
                if let jsondata = json as? [String: Any],
                    let name = jsondata["name"] as? String,
                    let description = jsondata["description"] as? String,
                    let description_2 = jsondata["description_2"] as? String,
                    let cost_text = jsondata["cost_text"] as? String,
                    let cost_sum = jsondata["cost_sum"] as? String,
                    let longitude = jsondata["longitude"] as? Double,
                    let latitude = jsondata["latitude"] as? Double,
                    let phone = jsondata["phone"] as? String,
                    let photos = jsondata["photos"] as? NSArray,
                    let category_id = jsondata["category_id"] as? [[String: Any]],
                    let icon = category_id[0]["icon"] as? String,
                    let typeName = category_id[0]["name"] as? String,
                    let picture = category_id[0]["picture"] as? String{
                    
                    self.place.name = name
                    self.place.costInfo = ("\(cost_text): \(cost_sum) рублей")
                    self.place.description = description
                    self.place.latitude = latitude
                    self.place.latitude = longitude
                    self.place.phoneNumber = phone
                    self.place.images = photos as! [String]
                    self.place.workHours = description_2
                    self.place.typeIcon = icon
                    self.place.placeType = typeName
                    self.place.placeMainImg = picture
                }
      
        
                self .downloadImage(self.place.placeMainImg)
                self.downloadIcon(self.place.typeIcon, "CustomDescriptionPlaceCell")
                self.downloadIcon(self.place.typeIcon, "BasicImgLblTVCellAdress")
                self.downloadIcon(self.place.typeIcon, "BasicImgLblTVCellPhone")
                //self.mainImage.image = self.downloadImage(self.place.placeMainImg)
                self.tableViewPlaceInfo.reloadData()
            }
        }
    }
    
    
    func downloadImage(_ url: String) {
    
        let urlPath = ("http://138.68.68.166:9999\(url)")
        Alamofire.request(urlPath).responseImage { response in
            if let imag = response.result.value {
                print("image downloaded1: \(urlPath)")
                
                self.mainImage.image = imag
            }
        }
    }
    
    
    
    func downloadIcon(_ url: String, _ cellName: String) {
        
        let urlPath = ("http://138.68.68.166:9999\(url)")
        Alamofire.request(urlPath).responseImage  { response  in
            if let imag = response.result.value {
                
                print("image downloaded2: \(urlPath)")
                //               self.cellsArray[0].image = imag
                //              print("ghbhd\(self.cellsArray)")
                
                switch cellName {
                case "CustomDescriptionPlaceCell":
                    self.cellsArray[0].image = imag
                    print("image CustomDescriptionPlaceCell downloaded2: \(urlPath)")
                    break
                    
                case "BasicImgLblTVCellPhone":
                    self.cellsArray[1].image = imag
                    break
                    
                case "BasicImgLblTVCellAdress":
                    self.cellsArray[2].image = imag
                    break
                    
                default:
                    break
                }
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     print("contentOffset \(scrollView.contentOffset)")
//        if scrollView == self.scrollView {
//            if scrollView.contentOffset == scrollOffset {
//                scrollView.isScrollEnabled = false
//                tableViewPlaceInfo.isScrollEnabled = true
//            }
//
//        }else if scrollView.contentOffset == scrollOffset {
//            scrollView.isScrollEnabled = false
//            tableViewPlaceInfo.isScrollEnabled = true
//        }
//        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
