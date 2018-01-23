//
//  MapViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, LocationService {

    @IBOutlet weak var mapView: MKMapView!

    private var locationController: LocationController!
    
    func setLocationService(_ lc: LocationController) {
        locationController = lc
    }
    
    func assertLocationService() {
        assert(locationController != nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationController.status.observeNext{ [unowned self] _ in
                self.mapView!.showsUserLocation = true
        }.dispose(in: bag)
        
        locationController.current.observeNext{ [unowned self] e in
            
            let userLocation = CLLocation(latitude: e.source.dictionary["lat"]!, longitude: e.source.dictionary["lng"]!)
            print("current location : \(userLocation)")
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1500, 1500)
            self.mapView?.setRegion(region, animated: true)
            
        }.dispose(in: bag)

//        let loc = try? Location.init(["name":"home","geometry":["lat":12.3,"lng":45.6]])
//        if let l = loc { print(l)}
    }

}
