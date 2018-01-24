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

protocol LocationTrackerStore {
    associatedtype T
    func setLocationTrackerStore(_ : T)
    func assertLocationTrackerStore()
}

class LocationTracker {
    
    let status = Property<Int>(0)
    let current = try? Location("Home")
    
    init() {

        Locator.requestAuthorizationIfNeeded(.whenInUse)
      
        Locator.events.listen { newStatus in
            print("Authorization status changed to \(newStatus)")
            self.status.value = Int(newStatus.rawValue)
        }
        updateCurrentPosition()
    }
    
    func updateCurrentPosition() {

        // one shot
        Locator.currentPosition(accuracy: .house, onSuccess: { newLocation in
            self.current?.lat.value = newLocation.coordinate.latitude
            self.current?.lng.value = newLocation.coordinate.longitude
        }, onFail: { err, last in
            //TODO: handle error
            print("Failed with error: \(err)")
        })
    }
}
