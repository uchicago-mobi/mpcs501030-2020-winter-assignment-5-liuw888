//
//  Place.swift
//  project5
//
//  Created by Wenzhe Liu on 2/9/20.
//  Copyright © 2020 Wenzhe Liu. All rights reserved.
//

import UIKit
import MapKit

class Place: MKPointAnnotation {
    var name: String?
    var longDescription: String?
    var location: CLLocationCoordinate2D
    init(name: String, longDescription: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.longDescription = longDescription
        self.location = location
    }
}
