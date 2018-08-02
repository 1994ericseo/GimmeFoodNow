import Foundation
import CoreData
import UIKit

class RestaurantViewModel {
    
    let name: String
    let phoneNumber: String
    let priceLevel: String
    let rating: Int?
    let url: String
    let showFavoritesButton: Bool
    
    weak var delegate: RestaurantViewControllerDelegate?
    
    init(restaurant: Restaurant, showFavoritesButton: Bool) {
        name = restaurant.name ?? ""
        phoneNumber = restaurant.phone ?? ""
        priceLevel = restaurant.price ?? ""
        rating = restaurant.rating
        url = restaurant.url ?? ""
        self.showFavoritesButton = showFavoritesButton
    }
    
    func addToFavorites() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "Restaurants", in: context) else {
                return
            }
            let newRestaurant = NSManagedObject(entity: entity, insertInto: context)
            newRestaurant.setValue(name, forKey: "name")
            do {
                try context.save()
                delegate?.addedToFavorites()
            } catch {
                delegate?.unableToFavorite()
            }
        }
    }
}
