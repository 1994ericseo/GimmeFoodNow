import XCTest

class RestaurantTests: XCTestCase {
    
    let helper = JSONSerializationHelper()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRating() {
        guard let json = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        if let restaurants = helper.parseYelpRestaurants(json: json) {
            XCTAssertEqual(restaurants[0].rating, 4)
        } else {
            XCTFail()
        }
    }
    
    func testPrice() {
        guard let json = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        if let restaurants = helper.parseYelpRestaurants(json: json) {
            XCTAssertEqual(restaurants[0].price, "$")
        } else {
            XCTFail()
        }
    }
    
    func testPhone() {
        guard let json = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        if let restaurants = helper.parseYelpRestaurants(json: json) {
            XCTAssertEqual(restaurants[0].phone, "+14152520800")
        } else {
            XCTFail()
        }
    }
    
    func testName() {
        guard let json = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        if let restaurants = helper.parseYelpRestaurants(json: json) {
            XCTAssertEqual(restaurants[0].name, "Four Barrel Coffee")
        } else {
            XCTFail()
        }
    }
    
    func testURL() {
        guard let json = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        if let restaurants = helper.parseYelpRestaurants(json: json) {
            XCTAssertEqual(restaurants[0].url, "https://www.yelp.com/biz/four-barrel-coffee-san-francisco")
        } else {
            XCTFail()
        }
    }
    
    
    
}
