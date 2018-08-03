import Foundation

class YelpSearchRequests {
    
    private let searchRequest = "/v3/businesses/search"
    private let yelpNetworkLayer = YelpNetworkLayer()
    
    func searchWithLatLong(lat: Double, long: Double, completion: @escaping (Any, Error?) -> Void) {
        let request = yelpNetworkLayer.createRequest(path: searchRequest, params: ["latitude": String(describing: lat), "longitude": String(describing: long)])
        yelpNetworkLayer.query(request: request) { (data, error) in
            completion(data, error)
        }
    }
}
