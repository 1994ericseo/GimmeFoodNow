import Foundation
import CoreData
import UIKit

protocol PreventUnitTestErrorAppDelegate: class {
    func persistentContainerFunc() -> NSPersistentContainer
}

class RestaurantViewModel {
    
    let name: String
    let phoneNumber: String
    let priceLevel: String
    let rating: Int?
    let url: String
    var showFavoriteButton: Bool
    var appDelegate: UIApplicationDelegate?
    
    weak var delegate: RestaurantViewControllerDelegate?
    
    init(restaurant: Restaurant, showFavoriteButton: Bool, appDelegate: UIApplicationDelegate? = nil) {
        name = restaurant.name ?? ""
        phoneNumber = restaurant.phone ?? ""
        priceLevel = restaurant.price ?? ""
        rating = restaurant.rating
        url = restaurant.url ?? ""
        self.showFavoriteButton = showFavoriteButton
        self.appDelegate = appDelegate
    }
    
    func addToFavorites() {
        if let appDelegate = appDelegate as? PreventUnitTestErrorAppDelegate {
            let context = appDelegate.persistentContainerFunc().viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "Restaurants", in: context) else {
                return
            }
            let newRestaurant = NSManagedObject(entity: entity, insertInto: context)
            newRestaurant.setValue(name, forKey: "name")
            do {
                try context.save()
                showFavoriteButton = false
                delegate?.addedToFavorites()
            } catch {
                delegate?.unableToFavorite()
            }
        }
    }
}
