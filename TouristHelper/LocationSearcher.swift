//
//  LocationSearcher.swift
//  TouristHelper
//
//  Created by Stephen OHara on 25/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation


class LocationSearcher {
    
    let foundLocations: Array<Location> = []
    
    init() {
        
    }
}
/*
 //• TESTING
 let locationsService = GooglePlacesWebAPIService()
 
 locationsService.searchFromLocation(lat: newLocation.coordinate.latitude,
 lng: newLocation.coordinate.longitude,
 radius: 10000.0,
 type: "bank",//park,art_gallery,bank
 onCompletion: { (data) in
 
 // clear everything
 self.mapView.removeAnnotations(self.mapView.annotations)
 self.mapView.removeOverlays(self.mapView.overlays)
 
 let results = data["results"] as! Array<[String : Any]>
 var locationModelViews: Array<LocationModelView> = [] //• the store
 
 for localResult in results {
 
 if let loc = try? Location(localResult){
 
 let locModelView = LocationModelView(title: loc.title.value,
 coordinate: CLLocationCoordinate2DMake(loc.lat.value,loc.lng.value))
 locationModelViews.append(locModelView)
 }
 }
 
 var sortedLocations = locationModelViews.sorted { (a, b) -> Bool in
 
 if self.calcAngle(newLocation.coordinate,a.coordinate) <
 self.calcAngle(newLocation.coordinate,b.coordinate){
 
 return true
 }
 return false
 }
 let home = LocationModelView(title: "Home", coordinate: newLocation.coordinate)
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
 //• TESTING
*/
