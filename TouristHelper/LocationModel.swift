//
//  LocationModel.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation

struct Location {
    
    let title: String
    let location: (lat: Double, lng: Double)
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

        self.title = title
        self.location = (lat,lng)
    }
}

