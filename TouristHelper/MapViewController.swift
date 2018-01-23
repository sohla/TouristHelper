//
//  MapViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit
import MapKit
import ReactiveKit

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

        // mapView needs CLLocationManager status to be ok
        locationController.status.observeNext{ [unowned self] _ in
                self.mapView!.showsUserLocation = true
        }.dispose(in: bag)

        // group both properties and return tuple
        let lat:  Property<Double> = (locationController.current?.lat)!
        let lng:  Property<Double> = (locationController.current?.lng)!
        let coords = combineLatest(lat,lng) { lat, lng -> (Double,Double) in
            return (lat,lng)
        }
        // listen to group with tuple
        coords.observeNext{ [unowned self] e in
            let userLocation = CLLocation(latitude: e.0 , longitude: e.1)
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1500, 1500)
            self.mapView?.setRegion(region, animated: true)
        
        }.dispose(in: bag)
    }

}
