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
    
    init() {

        Locator.requestAuthorizationIfNeeded(.whenInUse)
        
        Locator.events.listen { newStatus in
            print("Authorization status changed to \(newStatus)")
            NotificationCenter.default.post(name: .authorizationStatusChanged , object:newStatus)
            self.updateCurrentPosition()
        }

    }
    
    func updateCurrentPosition() {

        // one shot
        Locator.currentPosition(accuracy: .house, onSuccess: { newLocation in
            NotificationCenter.default.post(name: .currentLocationUpdated , object:newLocation)
            
        }, onFail: { err, last in
            //TODO: handle error
            print("Failed with error: \(err)")
        })
    }
}

