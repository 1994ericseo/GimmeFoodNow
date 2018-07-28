
import Foundation

struct Restaurant {
    let rating: Int?
    let price: String?
    let phone: String?
    let name: String?
    let url: String?
    
}

extension Restaurant {
    init?(business: [String: Any]) {
        rating = business["rating"] as? Int
        price = business["price"] as? String
        phone = business["phone"] as? String
        name = business["name"] as? String
        url = business["url"] as? String
    }
}
