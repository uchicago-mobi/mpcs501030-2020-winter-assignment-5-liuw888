//
//  ViewController.swift
//  project5
//
//  Created by Wenzhe Liu on 2/9/20.
//  Copyright © 2020 Wenzhe Liu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, PlacesFavoritesDelegate{
    
  
    
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet { mapView.delegate = self }
    }
    @IBOutlet var locationName: UILabel!
    @IBOutlet var locationDesc: UILabel!
    @IBOutlet var fav: UIButton!
    var curPlace = Place(name: "000", longDescription: "000", location: CLLocationCoordinate2DMake(0, 0))
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        self.fav.isSelected = false
    }
    
    
    
    func favoritePlace(name: String) {
        var zoomLocation : CLLocationCoordinate2D?
        for place in DataManager.sharedInstance.listFavorites() {
            if place.name == name {
                zoomLocation = place.location
                break
            }
        }
        if zoomLocation != nil{
            let viewRegion = MKCoordinateRegion(center: zoomLocation!,
                                                     latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(viewRegion, animated: true)
            self.fav.isSelected = true
        }
        
    }
    
    @objc func pressFav(_ sender: UIButton){
        print("pressed!")
        if(curPlace.name == "000" && curPlace.longDescription == "000") {
            	
        } else {
            self.fav.isSelected = !self.fav.isSelected
            let placename = curPlace.name
            var delete = false
            for place in DataManager.sharedInstance.listFavorites() {
                if place.name == placename {
                    DataManager.sharedInstance.deleteFavorite(place: place)
                    fav.isSelected = false
                    delete = true
                    break
                }
            }
            if(!delete) {
                fav.isSelected = true
                DataManager.sharedInstance.saveFavorites(place: curPlace)
            }
        }
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        let zoomLocation = CLLocationCoordinate2DMake(41.881832, -87.623177)
        let viewRegion = MKCoordinateRegion(center: zoomLocation,
                                                 latitudinalMeters: 2000, longitudinalMeters: 2000)
        
        // Set the initial region on the map
        mapView.setRegion(viewRegion, animated: true)
    
        DataManager.sharedInstance.loadAnnotationFromPlist(filename: "Data")
        for place in DataManager.sharedInstance.places {
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.coordinate = place.location
            annotation.subtitle = place.longDescription
            mapView.addAnnotation(annotation)
        }
        fav.addTarget(self, action: #selector(pressFav(_:)), for: .touchUpInside)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavourite" {
            let favVC: FavoritesViewController = segue.destination as! FavoritesViewController
            favVC.delegate = self
        }
    }
    


}



extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        self.locationName.text = view.annotation?.title!
        self.locationDesc.text = view.annotation?.subtitle!
        if let cor = view.annotation?.coordinate {
            self.curPlace = Place(name: self.locationName.text!, longDescription: self.locationDesc.text!, location: cor)
            
        }
        for place in DataManager.sharedInstance.listFavorites() {
            if place.name == self.locationName.text {
                self.fav.isSelected = true
                break
            } else {
                self.fav.isSelected = false
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKPointAnnotation {
            let identifier = "CustomPin"
            
            var view: MKMarkerAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = PlaceMarkerView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = false
          
            }
            return view
        }
        return nil
    }
    
}




