//
//  PlaceMarkerView.swift
//  project5
//
//  Created by Wenzhe Liu on 2/9/20.
//  Copyright © 2020 Wenzhe Liu. All rights reserved.
//

import UIKit
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override var annotation: MKAnnotation? {
        willSet {
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = UIColor.red
            glyphImage = UIImage(systemName: "pin.fill")
        }
    }

}
