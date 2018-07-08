//
//  YelpNetworkLayer.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/7/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import Foundation

class YelpNetworkLayer {
    private let clientID = "RYoycHeSURF7B60tuQou_w"
    private let APIKey = "U0yP6dXM7e2FrRXTf6HbVuvDO9Jj2LdsHWdlZgYymlgZIep1ua7wryiFPfqCzH6JrMOfB0lIhdPTbO0pY-d7JqOaJ7NiYhMUaUwRl7rc9Ieu-asgoVWoH9mOHo5BW3Yx"
    private let searchRequestURL = "https://api.yelp.com/v3/businesses/search"
    
    
    func queryItems(params: Dictionary<String, String?>) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        for (name, value) in params {
            let queryItem = URLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
        }
        return queryItems
    }
}
