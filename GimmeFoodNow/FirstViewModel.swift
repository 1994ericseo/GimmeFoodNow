import Foundation
import CoreLocation
import UIKit

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
                    DispatchQueue.main.async {
                        self?.delegate?.showRestaurantViewController(viewModel: RestaurantViewModel(restaurant: randomRestaurant,
                                                                                                showFavoriteButton: true,
                                                                                                appDelegate: UIApplication.shared.delegate as! AppDelegate))
                    }
                }
            }
        }
    }
    
    func pickRandomRestaurant(restaurants: [Restaurant]) -> Restaurant? {
        return restaurants.randomItem()
    }
}
