//
//  TransportViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class TransportViewController: UIViewController, LocationService {

    private var locationController: LocationController!
    
    func setLocationService(_ lc: LocationController) {
        locationController = lc
    }
    
    func assertLocationService() {
        assert(locationController != nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPreviousTouchUp(_ sender: Any) {
    }
    @IBAction func onHomeTouchUp(_ sender: Any) {

        // hack an update for now
        let _ = locationController.current.updateValue(0, forKey: "update")
    }
    @IBAction func onNextTouchUp(_ sender: Any) {
    }

}
