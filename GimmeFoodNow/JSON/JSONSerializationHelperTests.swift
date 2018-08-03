import XCTest

class JSONSerializationHelperTests: XCTestCase {
    
    func testWithArrayFile() {
        guard let _ = JSONSerializationHelper().getJSON(fileName: "Array") as? [Any] else {
            XCTFail()
            return
        }
    }
    
    func testWithDictionaryFile() {
        guard let _ = JSONSerializationHelper().getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
    }
    
    func testParseYelpRestaurants() {
        let helper = JSONSerializationHelper()
        guard let exampleYelpResponse = helper.getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        XCTAssertNotNil(helper.parseYelpRestaurants(json: exampleYelpResponse))
    }
}
