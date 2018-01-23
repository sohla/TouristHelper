//
//  LocationModel.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

struct Location {
    
    let title = Property<String>("zero")
    let lat = Property<Double>(0)
    let lng = Property<Double>(0)
}

enum SerializationError: Error {
    
    case missing(String)
    case invalid(String, Any)
}

extension Location {

    init(_ data: [String: Any]) throws {
     
        guard let title = data["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let geom = data["geometry"] as? [String: Any],
            let lat = geom["lat"] as? Double,
            let lng = geom["lng"] as? Double
            else {
                throw SerializationError.missing("geometry")
        }
        
        self.title.value = title
        self.lat.value = lat
        self.lng.value = lng
    }
    
    init(_ name: String) throws {
        try! self.init(["name":name,"geometry":["lat":1.23,"lng":4.56]])
    }
}

