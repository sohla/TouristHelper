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


extension Notification.Name {
    static let locationSelected = Notification.Name("locationSelected")
}

class MapViewController: UIViewController, LocationTrackerStore, MKMapViewDelegate {

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

        assertLocationTrackerStore()
        
        self.mapView.delegate = self
        
        // mapView needs CLLocationManager status to be ok
        locationTracker.status.observeNext{ [unowned self] _ in
            self.mapView!.showsUserLocation = true
        }.dispose(in: bag)

        // group both properties
        //TODO: combineLatest not working?
        let lat = (locationTracker.current?.lat)!
        let lng = (locationTracker.current?.lng)!
        let _ = combineLatest(lat,lng).observeNext{ [unowned self] (lat,lng) in
            let newLocation = CLLocation(latitude: lat, longitude: lng)
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 15000, 15000)
            self.mapView?.setRegion(region, animated: true)

            self.findPlacesWith(currentLocation: newLocation)

        }.dispose(in: bag)
    }
    
    //MARK:- DEMO FUNCTION
    // Quick hack finding a bunch of places from google,
    // sorting them out and presenting them on the mapview
    // None of this code belongs here and needs to be abstracted
    // to a better place.
    // change kPlaceType for different searches eg: park,art_gallery,bank
    let kPlaceType = "bank"
    
    func findPlacesWith(currentLocation: CLLocation) {
        
        let locationsService = GooglePlacesWebAPIService()
        
        locationsService.searchFromLocation(lat: currentLocation.coordinate.latitude,
                                            lng: currentLocation.coordinate.longitude,
                                            radius: 10000.0,
                                            type: kPlaceType,
            onCompletion: { (results) in
                
                print("Found \(results.count) Places")

                // clear everything
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.removeOverlays(self.mapView.overlays)
                
                var locationModelViews: Array<LocationModelView> = [] 
                
                for localResult in results {
                    
                    if let loc = try? Location(localResult){
                        
                        let locModelView = LocationModelView(location: loc)
                        locationModelViews.append(locModelView)
                    }
                }
                
                // basic sort by calc. angle made by the origin (user location)
                // and each places loaction.
                var sortedLocations = locationModelViews.sorted { (a, b) -> Bool in
                    
                    if self.calcAngle(currentLocation.coordinate,a.coordinate) <
                        self.calcAngle(currentLocation.coordinate,b.coordinate){
                        
                        return true
                    }
                    return false
                }
                // add users location to being and end of the list
                let home = LocationModelView(title: "Home", coordinate: currentLocation.coordinate)
                sortedLocations.insert(home, at: 0)
                sortedLocations.append(home)
                
                var locations = sortedLocations.map { $0.coordinate }
                let polyline = MKPolyline(coordinates: &locations, count: sortedLocations.count)
                self.mapView.add(polyline)
                self.mapView.addAnnotations(locationModelViews)
                
                // trigger selecting user annotation
                if let userAnnotation = self.mapView!.annotations.first(where: { (a) -> Bool in
                    a is MKUserLocation
                }){
                    self.mapView!.selectAnnotation(userAnnotation, animated: false)
                }
                
        })
    }
    
    // helper func to calc. angle from origin to pnt
    func calcAngle(_ origin:CLLocationCoordinate2D,
                   _ pnt:CLLocationCoordinate2D) -> Double {
 
        let rad = atan2(pnt.latitude - origin.latitude, pnt.longitude - origin.longitude)
        let ang = rad * (180.0 / Double.pi)
        return ang
    }
    
    // MARK: MapView Delegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
        
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.init(red: 0.99, green: 0.36, blue: 0.3, alpha: 1.0)
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotationViewModel = view.annotation as? LocationModelView {
            NotificationCenter.default.post(name: .locationSelected, object:annotationViewModel)
        }
        
        // get the user Annotation and make a LocationModelView to send
        if let userAnnotation = view.annotation as? MKUserLocation {
            let myLocation = LocationModelView(title: userAnnotation.title!,
                                               coordinate: userAnnotation.coordinate)
            NotificationCenter.default.post(name: .locationSelected,
                                            object:myLocation)
        }
    }
}

