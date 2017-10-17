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
    
    // @IBOutlet weak var designView: UIView!
    @IBOutlet weak var tableViewPlaceInfo: UITableView!
    @IBOutlet weak var mainImage: UIImageView!
    
    var scrollOffset: CGPoint!
//    
//    let realm = try! Realm()
//    lazy var categories: Results<PlacesCategories> = { self.realm.objects(PlacesCategories.self) }()
//    lazy var points: Results<PlaceModel> = { self.realm.objects(PlaceModel.self) }()
//    
//
    struct cellData {
        let name: String!
        var image: UIImage!
    }
    
    var place = PlaceModel()
    var photos = PhotosModel()
    
    var cellsArray = [cellData(name: "CustomDescriptionPlaceCell", image: #imageLiteral(resourceName: "defImg")),cellData(name: "BasicImgLblTVCellPhone", image: #imageLiteral(resourceName: "defImg")),cellData(name: "BasicImgLblTVCellAdress", image: #imageLiteral(resourceName: "defImg"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewPlaceInfo.dataSource = self
        self.tableViewPlaceInfo.delegate = self
        navigationController?.navigationBar.isHidden = true
        
        // self.designView.layer.cornerRadius = 8
        // self.tableViewPlaceInfo.contentInset = UIEdgeInsetsMake(44,0,0,0);
        //self.scrollView.contentSize.height = 8000
        scrollOffset = CGPoint.init(x: 0.0, y: -60.0) // скролл не готов y:высота фотки
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableViewPlaceInfo.contentInset = UIEdgeInsetsMake(mainImage.frame.height,0,0,0);
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellsArray[indexPath.row].name {
            
        case "BasicImgLblTVCellPhone":
            
            let cell = Bundle.main.loadNibNamed("BasicImgLblTVCell", owner: self, options: nil)?.first as! BasicImgLblTVCell
            
            cell.cellText.text = place.phone
            
            //self.downloadIcon(place.typeIcon, "BasicImgLblTVCellPhone")
            
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
            cell.placeCostDetails.text = ("\(place.cost_text!) \(place.cost_sum!)")
            cell.placeWorkingHours.text = place.description_2
            
            
            let urlPath = ("\(baseURL)")
            Alamofire.request(urlPath).responseImage  { response  in
                if let imag = response.result.value {
                    cell.placeTypeIcon.image = imag
                }
            } // переделать позже
            
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
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellsArray[indexPath.row].name {
        case "BasicImgLblTVCell":
            return 72
            
        case "CustomDescriptionPlaceCell":
            
            return 867 //как вычислить эту ячейку?
            
            //        case "TransparentCell":
            //            return mainImage.frame.height
            
            
        default:
            return 72
        }
        
        
    }
    
    
    
    func downloadImage(place_id : int) {
        
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
