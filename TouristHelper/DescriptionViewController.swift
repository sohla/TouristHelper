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
    
    private var locationController: LocationTracker!

    func setLocationTrackerStore(_ lc: LocationTracker) {
        locationController = lc
    }
    
    func assertLocationTrackerStore() {
        assert(locationController != nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assertLocationTrackerStore()
        
        locationController.current?.title.observeNext{ [unowned self] t in
            self.titleLabel.text = t
        }.dispose(in: bag)
        
    }
}
