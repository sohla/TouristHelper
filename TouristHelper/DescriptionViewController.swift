//
//  DescriptionViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, LocationTrackerStore {

    @IBOutlet weak var titleLabel: UILabel!
    
    private var locationTracker: LocationTracker!

    func setLocationTrackerStore(_ lc: LocationTracker) {
        locationTracker = lc
    }
    
    func assertLocationTrackerStore() {
        assert(locationTracker != nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assertLocationTrackerStore()
        
        locationTracker.current?.title.observeNext{ [unowned self] t in
            self.titleLabel.text = t
        }.dispose(in: bag)
        
    }
}
