//
//  AllPlacesListViewController.swift
//  AmberCardKhoroshko
//
//  Created by Emma Khoroshko on 16.10.17.
//  Copyright © 2017 Emma Khoroshko. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift


class AllPlacesListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var designView: UIView!
    @IBOutlet weak var allContentTableView: UITableView!
    
    let realm = try! Realm()
    lazy var categories: Results<PlacesCategories> = { self.realm.objects(PlacesCategories.self) }()
    lazy var points: Results<PlaceModel> = { self.realm.objects(PlaceModel.self) }()
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("AllPlacesScreenCell", owner: self, options: nil)?.first as! AllPlacesScreenCell
        
        let place = points[indexPath.row]
        cell.placeName.text = place.name
        cell.placeDescription.text = place.description_text
        cell.setFonts()
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allContentTableView.dataSource = self
        self.allContentTableView.delegate = self
        
        navigationController?.navigationBar.isHidden = true
        self.fetchAllData()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
    
    func fetchAllData () {
        
        NetworkingService.shared.getAllPlaces()
        self.points = self.realm.objects(PlaceModel.self)
        print(self.points)
        self.categories = self.realm.objects(PlacesCategories.self)
        allContentTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "PlaceVC", sender: indexPath)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaceVC" , let vc =  segue.destination as? PlaceViewController , let indexPath =  self.allContentTableView.indexPathForSelectedRow {
            vc.place = self.points[indexPath.row]
            
        }
    }
}
