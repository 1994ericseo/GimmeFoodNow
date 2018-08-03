
import XCTest

class RestaurantViewModelTests: XCTestCase {
    
    func testRestaurantViewModelInit() {
        let helper = JSONSerializationHelper()
        guard let json = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        if let restaurants = helper.parseYelpRestaurants(json: json) {
            let viewModel = RestaurantViewModel(restaurant: restaurants[0], showFavoriteButton: true)
            XCTAssertEqual(viewModel.name, "Four Barrel Coffee")
            XCTAssertEqual(viewModel.phoneNumber, "+14152520800")
            XCTAssertEqual(viewModel.priceLevel, "$")
            XCTAssertEqual(viewModel.rating, 4)
            XCTAssertEqual(viewModel.url, "https://www.yelp.com/biz/four-barrel-coffee-san-francisco")
        } else {
            XCTFail()
        }
    }
    
}
