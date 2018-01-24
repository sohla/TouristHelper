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
    @IBOutlet weak var homeButton: UIButton!
    
    func setLocationTrackerStore(_ lc: LocationTracker) {
        locationTracker = lc
    }
    
    func assertLocationTrackerStore() {
        assert(locationTracker != nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeButton.reactive.tap.observeNext { [unowned self] _ in
            self.locationTracker.updateCurrentPosition()
        }.dispose(in: bag)
    }
}
