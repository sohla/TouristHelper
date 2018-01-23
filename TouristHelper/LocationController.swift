//
//  LocationController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftLocation
import ReactiveKit
import Bond

protocol LocationService {
    associatedtype T
    func setLocationService(_ : T)
    func assertLocationService()
}

class LocationController {
    
    var status = Property<Int>(0)
    //let current = MutableObservableDictionary(["lat":0.0,"lng":0.0])
    let current = try? Location(["name":"me","geometry":["lat":1.23,"lng":4.56]])
    
    
    init() {

        Locator.requestAuthorizationIfNeeded(.whenInUse)
      
        Locator.events.listen { newStatus in
            print("Authorization status changed to \(newStatus)")
            self.status.value = Int(newStatus.rawValue)
        }
        
        Locator.subscribePosition(accuracy: .city, onUpdate: { newLocation in
            
//            let nl = ["lat":newLocation.coordinate.latitude,
//                      "lng":newLocation.coordinate.longitude]
//            //let _ = self.current.replace(with: nl)
            
            
            self.current?.lat.value = newLocation.coordinate.latitude
            self.current?.lng.value = newLocation.coordinate.longitude

        
        
        }, onFail: { err, last in
            
            print("Failed with error: \(err)")
        })

//        // for low power use
//        Locator.subscribeSignificantLocations(onUpdate: { newLocation in
//            print("New location \(newLocation)")
//        }) { (err, lastLocation) -> (Void) in
//            print("Failed with err: \(err)")
//        }

    }
}
