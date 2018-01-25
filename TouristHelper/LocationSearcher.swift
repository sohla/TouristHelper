//
//  LocationSearcher.swift
//  TouristHelper
//
//  Created by Stephen OHara on 25/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
import MapKit



class LocationSearcher {
    
    let locationsService = GooglePlacesWebAPIService()
    
    init() {
    }

    let kPlaceType = PlaceTypes.places[Int(arc4random_uniform(UInt32(PlaceTypes.places.count)))].rawValue

    func findPlacesWith(location: CLLocation, onCompletion: @escaping ([LocationModelView]) -> Void ) {
        
        locationsService.searchFromLocation(lat: location.coordinate.latitude,
                                            lng: location.coordinate.longitude,
                                            radius: 10000.0,
                                            type: kPlaceType,
                                            onCompletion: { (results) in
                                                
            print("Found \(results.count) Places for Type : \(self.kPlaceType)")
            
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
                if self.calcAngle(location.coordinate,a.coordinate) <
                    self.calcAngle(location.coordinate,b.coordinate){
                    return true
                }
                return false
            }
            
            onCompletion(sortedLocations)
                                                
        })
    }
    
    
    // helper func to calc. angle from origin to pnt
    func calcAngle(_ origin:CLLocationCoordinate2D,
                   _ pnt:CLLocationCoordinate2D) -> Double {
        
        let rad = atan2(pnt.latitude - origin.latitude, pnt.longitude - origin.longitude)
        let ang = rad * (180.0 / Double.pi)
        return ang
    }
    

}


