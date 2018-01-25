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



class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let searcher = LocationSearcher()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.mapView.delegate = self
        
        NotificationCenter.default.reactive.notification(name: .authorizationStatusChanged)
            .observeNext { [unowned self] notification in

                self.mapView!.showsUserLocation = true
            }.dispose(in: bag)

        
        NotificationCenter.default.reactive.notification(name: .currentLocationUpdated)
            .observeNext { [unowned self] notification in

                if let newLocation = notification.object as? CLLocation {

                    let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 15000, 15000)
                    self.mapView?.setRegion(region, animated: true)

                    // search for new places and update map
                    self.searcher.findPlacesWith(location: newLocation, onCompletion: { (sortedLocations) in
                        self.refreshMapViewWithPlaces(locations: sortedLocations)
                    })
                }
            }.dispose(in: bag)
    }

    func refreshMapViewWithPlaces(locations: [LocationModelView]){

        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.removeOverlays(self.mapView.overlays)

        var locationsCoords = locations.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: &locationsCoords, count: locationsCoords.count)
        self.mapView.add(polyline)
        self.mapView.addAnnotations(locations)
        
        // trigger selecting user annotation
        if let userAnnotation = self.mapView!.annotations.first(where: { (a) -> Bool in
            a is MKUserLocation
        }){
            self.mapView!.selectAnnotation(userAnnotation, animated: false)
        }

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

