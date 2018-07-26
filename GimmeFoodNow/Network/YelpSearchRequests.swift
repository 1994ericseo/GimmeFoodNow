//
//  YelpSearchRequests.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/7/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//
import Foundation

class YelpSearchRequests {
    
    private let searchRequest = "/v3/businesses/search"
    private let yelpNetworkLayer = YelpNetworkLayer()
    
    func searchWithLatLong(lat: Float, long: Float) {
        let request = yelpNetworkLayer.createRequest(path: searchRequest, params: ["latitude": String(describing: lat), "longitude": String(describing: long)])
        yelpNetworkLayer.query(request: request) { (data, error) in
            print(data)
        }
    }
}
