//
//  YelpNetworkLayer.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/7/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import Foundation

struct YelpAPIStuff {
    static let host = "api.yelp.com"
    static let errorDomain = "com.yelp.YelpAPI.ErrorDomain"
}

class YelpNetworkLayer {
    private let clientID = "RYoycHeSURF7B60tuQou_w"
    private let apiKey = "U0yP6dXM7e2FrRXTf6HbVuvDO9Jj2LdsHWdlZgYymlgZIep1ua7wryiFPfqCzH6JrMOfB0lIhdPTbO0pY-d7JqOaJ7NiYhMUaUwRl7rc9Ieu-asgoVWoH9mOHo5BW3Yx"
    
    func createRequest(path: String, params: Dictionary<String, String?>) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = YelpAPIStuff.host
        components.path = path
        components.queryItems = self.queryItems(params: params)
        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let authHeader = String(format: "Bearer %@", apiKey)
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func query(request: URLRequest?, completion: @escaping (Any, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        guard let urlRequest = request else {
            return
        }
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        return
                    }
                    completion(jsonData, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func queryItems(params: Dictionary<String, String?>) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        for (name, value) in params {
            let queryItem = URLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
        }
        return queryItems
    }
}
