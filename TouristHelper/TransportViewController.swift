//
//  TransportViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class TransportViewController: UIViewController, LocationTrackerStore {

    private var locationTracker: LocationTracker!
    
    func setLocationTrackerStore(_ lc: LocationTracker) {
        locationTracker = lc
    }
    
    func assertLocationTrackerStore() {
        assert(locationTracker != nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func onPreviousTouchUp(_ sender: Any) {
    }
    @IBAction func onHomeTouchUp(_ sender: Any) {

        locationTracker.updateCurrentPosition()
    }
    @IBAction func onNextTouchUp(_ sender: Any) {
    }

}
