//
//  LocationStore.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import Foundation
import Networking

protocol LocationServiceProtocol {
    
    var baseURL: String {get}
    var key: String {get}
    
    func searchFromLocation(lat: Double, lng: Double, radius: Double, type: String, onCompletion:@escaping ([String:Any]) -> Void)
    //• onLocationFound(Location)->
}


struct GooglePlacesWebAPI : LocationServiceProtocol{
    
    // google pages at 20 results
    // TODO: add next_page_token with delay on request
    
    let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch"
    let key = "AIzaSyCF6AZHrPxujMBMpfOr6QbhSMkskWeoxfE"

    func searchFromLocation(lat: Double, lng: Double, radius: Double, type: String, onCompletion: @escaping ([String:Any]) -> Void){

        let networking = Networking(baseURL:self.baseURL)
        let locationString = lat.description+","+lng.description
        let params = [
            "location":locationString,
            "radius":radius.description,
            "type":type,
            //"keyword":"interest",
            "key":self.key
        ]
        
        networking.get("/json", parameters:params){ result in
            switch result {
            case .success(let response):
                print("================ SUCCESS ===================")
                // return a Location?
                onCompletion(response.dictionaryBody)

            case .failure(let response):
                //TODO: handle error
                let errorCode = response.error.code
                print("Error : \(errorCode)")
            }
        }
    }
}



class LocationStore {
    
    init() {
    }
    
}
