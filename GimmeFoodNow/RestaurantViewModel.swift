//
//  RestaurantViewModel.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/28/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import Foundation

class RestaurantViewModel {
    
    let name: String
    let phoneNumber: String
    let priceLevel: String
    let rating: Int?
    let url: String
    
    init(restaurant: Restaurant) {
        name = restaurant.name ?? ""
        phoneNumber = restaurant.phone ?? ""
        priceLevel = restaurant.price ?? ""
        rating = restaurant.rating
        url = restaurant.url ?? ""
    }
}
