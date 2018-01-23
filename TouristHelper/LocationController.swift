//
//  LocationController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
import SwiftLocation

class LocationController {
    
    init() {

        Locator.requestAuthorizationIfNeeded(.whenInUse)
      
        Locator.events.listen { newStatus in
            print("Authorization status changed to \(newStatus)")
        }
        
        Locator.subscribeSignificantLocations(onUpdate: { newLocation in
            print("New location \(newLocation)")
        }) { (err, lastLocation) -> (Void) in
            print("Failed with err: \(err)")
        }
    }
}
