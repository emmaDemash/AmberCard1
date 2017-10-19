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
import RealmSwift



//ШРИФТЫ!


class PlaceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let baseURL = "http://138.68.68.166:9999"
    @IBOutlet weak var tableViewPlaceInfo: UITableView!
    @IBOutlet weak var mainImage: UIImageView!
    
    var scrollOffset: CGPoint!
    
        struct cellData {
        let name: String!
        var image: UIImage!
    }
    
    var place = PlaceModel()
    var photos = PhotosModel()
    
    var cellsArray = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewPlaceInfo.dataSource = self
        self.tableViewPlaceInfo.delegate = self
        navigationController?.navigationBar.isHidden = true
        tableViewPlaceInfo.estimatedRowHeight = 44
        tableViewPlaceInfo.rowHeight = UITableViewAutomaticDimension
        self.createCellsArray()
        // self.designView.layer.cornerRadius = 8
        // self.tableViewPlaceInfo.contentInset = UIEdgeInsetsMake(44,0,0,0);
        //self.scrollView.contentSize.height = 8000
        scrollOffset = CGPoint.init(x: 0.0, y: -60.0)
        // скролл не готов y:высота фотки
        
        downloadIcon(place.photos[0].photo!)
        
        print(place.photos)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableViewPlaceInfo.contentInset = UIEdgeInsetsMake(mainImage.frame.height,0,0,0);
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellsArray[indexPath.row].name {
            
        case "BasicImgLblTVCellPhone":
            
            let cell = Bundle.main.loadNibNamed("BasicImgLblTVCell", owner: self, options: nil)?.first as! BasicImgLblTVCell
            cell.cellText.text = place.phone
            let urlPath = ("\(baseURL)") //узнать откуда брать иконки для телефона и адреса
            
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
            
            let urlPath = ("\(baseURL)") //\(place.typeIcon)
            
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.icon.image = imag
                }
            } // переделать позже
            return cell
            
        case "CustomDescriptionPlaceCell":
            let cell = Bundle.main.loadNibNamed("CustomDescriptionPlaceCell", owner: self, options: nil)?.first as! CustomDescriptionPlaceCell
            
            
            cell.placeType.text = "Музей"
            cell.placeName.text = place.name
            cell.placeDescription.text = place.description_text
            let urlPath = ("\(baseURL)")
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.placeTypeIcon.image = imag
                }
            } // переделать позже
            
            return cell
        case "BasicCellCostInfo":
            let cell = Bundle.main.loadNibNamed("TransparentCell", owner: self, options: nil)?.first as! TransparentCell
            
            cell.textCell.text = ("\(place.cost_text!) \(place.cost_sum!)") // нет адреса в
            return cell
        case "BasicCellWorkingHours":
            
            let cell = Bundle.main.loadNibNamed("TransparentCell", owner: self, options: nil)?.first as! TransparentCell
            
            cell.textCell.text = place.description_2
            
            return cell
            
        default:
            
            let cell = Bundle.main.loadNibNamed("TransparentCell", owner: self, options: nil)?.first as! TransparentCell
            
            cell.backgroundColor = UIColor.clear
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsArray.count
    }
    
    
    func createCellsArray() {
        // var arrayCells : [cellData]
        
        if (place.description_text != "") {
            cellsArray.append(cellData(name: "CustomDescriptionPlaceCell", image: #imageLiteral(resourceName: "defImg")))
        }
        if place.description_2 != ""{
            cellsArray.append(cellData(name: "BasicCellWorkingHours", image: #imageLiteral(resourceName: "defImg")))
        }
        if (place.cost_sum != "") {
            cellsArray.append(cellData(name: "BasicCellCostInfo", image: #imageLiteral(resourceName: "defImg")))
        }
        if (place.phone != "") {
            cellsArray.append(cellData(name: "BasicImgLblTVCellPhone", image: #imageLiteral(resourceName: "defImg")))
        }
        if (place.phone != "") {
            cellsArray.append(cellData(name: "BasicImgLblTVCellAdress", image: #imageLiteral(resourceName: "defImg")))
        }
        
    }
    
    
    func downloadIcon(_ url: String) {
        
        let urlPath = ("http://138.68.68.166:9999\(url)")
        Alamofire.request(urlPath).responseImage  { response  in
            if let imag = response.result.value {
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
        
        if (scrollView.contentOffset.y >= scrollOffset.y) {
            self.createNavigationBarWithoutBorders()
            
        } else {
            navigationController?.navigationBar.isHidden = true
        }
        
        
    }
    func createNavigationBarWithoutBorders() {
        
        navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        
    }
    
    //    - (void) createnNavigationBarWithoutBorders {
    //
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    }
    
    
    
    
    
}
