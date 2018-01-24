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

//• test class
class LocalThing: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}


class MapViewController: UIViewController, LocationTrackerStore {

    @IBOutlet weak var mapView: MKMapView!

    private var locationTracker: LocationTracker!
    
    func setLocationTrackerStore(_ lc: LocationTracker) {
        locationTracker = lc
    }
    
    func assertLocationTrackerStore() {
        assert(locationTracker != nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // mapView needs CLLocationManager status to be ok
        locationTracker.status.observeNext{ [unowned self] _ in
                self.mapView!.showsUserLocation = true
        }.dispose(in: bag)

        // group both properties
        let lat = (locationTracker.current?.lat)!
        let lng = (locationTracker.current?.lng)!
        let _ = combineLatest(lat,lng).observeNext{ [unowned self] (lat,lng) in
            
            let newLocation = CLLocation(latitude: lat, longitude: lng)
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1000, 1000)
            self.mapView?.setRegion(region, animated: true)

            //• TESTING
             let locationService: LocationServiceProtocol = GooglePlacesWebAPI()
             
             locationService.searchFromLocation(lat: newLocation.coordinate.latitude, lng: newLocation.coordinate.longitude, radius: 500.0, type: "cafe", onCompletion: { (data) in
                
                let results = data["results"] as! Array<[String : Any]>
                for locale in results {

                    if let loc = try? Location(locale){
                    
                        let lc = CLLocationCoordinate2DMake(loc.lat.value,loc.lng.value)
                        let ant = LocalThing(title: loc.title.value, locationName: loc.title.value, coordinate: lc)
                        self.mapView.addAnnotation(ant)
                    }
                }
             
             })
            //• TESTING


        }.dispose(in: bag)
    }

}
