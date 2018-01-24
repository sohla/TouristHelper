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

            //• TESTING
             let locationsService = GooglePlacesWebAPIService()
             
             locationsService.searchFromLocation(lat: newLocation.coordinate.latitude, lng: newLocation.coordinate.longitude, radius: 10000.0, type: "park", onCompletion: { (data) in
                
                // clear everything
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.removeOverlays(self.mapView.overlays)
                
                let results = data["results"] as! Array<[String : Any]>
                var nots: Array<LocalThing> = []
                
                for locale in results {

                    if let loc = try? Location(locale){
                    
                        let lc = CLLocationCoordinate2DMake(loc.lat.value,loc.lng.value)
                        let ant = LocalThing(title: loc.title.value, locationName: loc.title.value, coordinate: lc)
                        nots.append(ant)
                    }
                }

                let locations = nots.map { $0.coordinate }
                var sortedLocations = locations.sorted { (a, b) -> Bool in
                    if self.calcAngle(newLocation.coordinate,a) < self.calcAngle(newLocation.coordinate,b){ return true }
                    return false
                }
                sortedLocations.insert(newLocation.coordinate, at: 0)
                sortedLocations.append(newLocation.coordinate)
                let polyline = MKPolyline(coordinates: &sortedLocations, count: sortedLocations.count)
                self.mapView.add(polyline)
                self.mapView.addAnnotations(nots)

             })
            //• TESTING


        }.dispose(in: bag)
    }
    
    // helper func to calc. angle from origin to pnt
    func calcAngle(_ origin:CLLocationCoordinate2D, _ pnt:CLLocationCoordinate2D) -> Double {
 
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
}
/*
 // google places API : TYPES
 accounting
 airport
 amusement_park
 aquarium
 art_gallery
 atm
 bakery
 bank
 bar
 beauty_salon
 bicycle_store
 book_store
 bowling_alley
 bus_station
 cafe
 campground
 car_dealer
 car_rental
 car_repair
 car_wash
 casino
 cemetery
 church
 city_hall
 clothing_store
 convenience_store
 courthouse
 dentist
 department_store
 doctor
 electrician
 electronics_store
 embassy
 fire_station
 florist
 funeral_home
 furniture_store
 gas_station
 gym
 hair_care
 hardware_store
 hindu_temple
 home_goods_store
 hospital
 insurance_agency
 jewelry_store
 laundry
 lawyer
 library
 liquor_store
 local_government_office
 locksmith
 lodging
 meal_delivery
 meal_takeaway
 mosque
 movie_rental
 movie_theater
 moving_company
 museum
 night_club
 painter
 park
 parking
 pet_store
 pharmacy
 physiotherapist
 plumber
 police
 post_office
 real_estate_agency
 restaurant
 roofing_contractor
 rv_park
 school
 shoe_store
 shopping_mall
 spa
 stadium
 storage
 store
 subway_station
 supermarket
 synagogue
 taxi_stand
 train_station
 transit_station
 travel_agency
 veterinary_care
 zoo
 */
