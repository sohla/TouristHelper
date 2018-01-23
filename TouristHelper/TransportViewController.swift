//
//  TransportViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class TransportViewController: UIViewController, LocationTrackerStore {

    private var locationController: LocationTracker!
    
    func setLocationTrackerStore(_ lc: LocationTracker) {
        locationController = lc
    }
    
    func assertLocationTrackerStore() {
        assert(locationController != nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func onPreviousTouchUp(_ sender: Any) {
    }
    @IBAction func onHomeTouchUp(_ sender: Any) {

        //• hack an update for now
        locationController.current?.lat.value = (locationController.current?.lat.value)!
    }
    @IBAction func onNextTouchUp(_ sender: Any) {
    }

}
