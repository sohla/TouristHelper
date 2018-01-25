//
//  LocationModelView.swift
//  TouristHelper
//
//  Created by Stephen OHara on 25/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
import MapKit

class LocationModelView: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
    
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    
    convenience init(location: Location){
        
        self.init(title: location.title.value, coordinate: CLLocationCoordinate2D(latitude: location.lat.value, longitude: location.lng.value) )
        
    }
    
}
