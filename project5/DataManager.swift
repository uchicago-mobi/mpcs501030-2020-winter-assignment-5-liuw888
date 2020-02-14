//
//  DataManager.swift
//  project5
//
//  Created by Wenzhe Liu on 2/11/20.
//  Copyright © 2020 Wenzhe Liu. All rights reserved.
//

import Foundation
import MapKit

struct Root : Decodable {

    struct placeItem : Decodable {
        let name: String
        let description: String
        let lat: Double
        let long: Double
        let type: Int
    }
    
    let places : [placeItem]
    let region : [Double]
}




public class DataManager {
    var places: [Place]
    var favourites: [Place]
    // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
    
    //This prevents others from using the default '()' initializer
    fileprivate init() {
        self.places = []
        self.favourites = []
    }
    
    // Your code (these are just example functions, implement what you need)
    func loadAnnotationFromPlist(filename: String) {
        print("is called")
        print(filename)
        
        if let path = Bundle.main.path(forResource: filename, ofType: "plist"),
        let xml = FileManager.default.contents(atPath: path),
        let plist = try? PropertyListDecoder().decode(Root.self, from: xml) {
            for place in plist.places {
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(place.lat), longitude: CLLocationDegrees(place.long))
                let new = Place(name: place.name, longDescription: place.description, location: location)
                self.places.append(new)
            }
        }
        
        
    }
    func saveFavorites(place: Place) {
        for p in self.places {
            if p.name == place.name {
                self.favourites.append(p)
            }
        }
    }
    func deleteFavorite(place: Place) {
        var count = 0
        for fav in self.favourites {
            if fav.name == place.name {
                self.favourites.remove(at: count)
                break
            }
            count += 1
        }
    }
    func listFavorites() -> [Place] {
        return self.favourites
    }
    
}
