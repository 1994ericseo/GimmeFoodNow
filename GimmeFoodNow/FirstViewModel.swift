//
//  MainViewModel.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/5/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import Foundation
import CoreLocation

class FirstViewModel: NSObject, CLLocationManagerDelegate {
    weak var delegate: FirstViewControllerDelegate?
    
    let locationManager = CLLocationManager()
    let buttonTitle = "Find me food"
    
    
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func currentLatLongCoordinate() -> CLLocationCoordinate2D? {
        guard let location = locationManager.location else {
            return nil
        }
        return location.coordinate
    }
    
    func findMeFoodAction() {
        guard let currentLatLongCoordinate = currentLatLongCoordinate() else {
            self.delegate?.showErrorState()
            return
        }
        delegate?.updateLoadingState(isLoading: true)
        let lat = Double(currentLatLongCoordinate.latitude)
        let long = Double(currentLatLongCoordinate.longitude)
        YelpSearchRequests().searchWithLatLong(lat: lat, long: long) { [weak self] (data, error) in
            self?.delegate?.updateLoadingState(isLoading: false)
            
            guard let jsonData = data as? [String: Any] else {
                return
            }
            let serializationHelper = JSONSerializationHelper()
            if let restaurants = serializationHelper.parseYelpRestaurants(json: jsonData) {
                if let randomRestaurant = self?.pickRandomRestaurant(restaurants: restaurants) {
                    self?.delegate?.showRestaurantViewController(viewModel: RestaurantViewModel(restaurant: randomRestaurant, showFavoritesButton: true))
                }
            }
        }
    }
    
    func pickRandomRestaurant(restaurants: [Restaurant]) -> Restaurant? {
        return restaurants.randomItem()
    }
}
