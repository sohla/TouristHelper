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

    init(json: [String: Any]) throws {
     
        guard let title = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let geom = json["geometry"] as? [String: Any],
            let lat = geom["lat"] as? Double,
            let lng = geom["lng"] as? Double
            else {
                throw SerializationError.missing("geometry")
        }

        self.title = title
        self.location = (lat,lng)
    }
}
