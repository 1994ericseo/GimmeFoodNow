import Foundation

class JSONSerializationHelper {
    func getJSON(fileName: String) -> Any? {
        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: [])
                return jsonResult
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func parseYelpRestaurants(json: [String: Any]) -> [Restaurant]? {
        var restaurants: [Restaurant] = []
        guard let businesses = json["businesses"] as? [Any] else {
            return nil
        }
        for business in businesses {
            if let restaurant = business as? [String: Any] {
                restaurants.append(Restaurant(rating: restaurant["rating"] as? Int,
                                              price: restaurant["price"] as? String,
                                              phone: restaurant["phone"] as? String,
                                              name: restaurant["name"] as? String,
                                              url: restaurant["url"] as? String))
            }
        }
        return restaurants
    }
}
