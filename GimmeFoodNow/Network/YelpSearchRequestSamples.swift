//
//  YelpSearchRequest.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/7/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//
import Foundation

class YelpSearchRequestSamples {
    func searchWithLatLong(lat: Float, long: Float) {
        let searchRequest = "/v3/businesses/search"
        let yelpNetworkLayer = YelpNetworkLayer()
        let request = yelpNetworkLayer.createRequest(path: searchRequest, params: ["latitude": String(describing: lat), "longitude": String(describing: long)])
        yelpNetworkLayer.query(request: request) { (data, error) in
            print(data)
        }
    }
}
