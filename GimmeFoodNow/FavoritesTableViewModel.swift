import Foundation
import CoreData
import UIKit

class FavoritesTableViewModel {
    var data: [Restaurant] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurants")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let name = data.value(forKey: "name") as? String {
                    self.data.append(Restaurant(rating: nil, price: nil, phone: nil, name: name, url: nil))
                }
            }
        } catch {
            
        }
    }
}
