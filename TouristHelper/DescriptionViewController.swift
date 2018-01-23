//
//  DescriptionViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, LocationService {

    @IBOutlet weak var titleLabel: UILabel!
    
    private var locationController: LocationController!

    func setLocationService(_ lc: LocationController) {
        locationController = lc
    }
    
    func assertLocationService() {
        assert(locationController != nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assertLocationService()
        
        locationController.current?.title.observeNext{ [unowned self] t in
            self.titleLabel.text = t
        }.dispose(in: bag)
        
    }
}
