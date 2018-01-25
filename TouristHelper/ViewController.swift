//
//  ViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let locationTracker = LocationTracker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // "inject" each vc with the tracker
        if segue.identifier == "transportSegueID" {
            let tvc = segue.destination as? TransportViewController
            tvc?.setLocationTrackerStore(locationTracker)
        }

    }
    
    // searcher
    // when done tell map view to update
}

