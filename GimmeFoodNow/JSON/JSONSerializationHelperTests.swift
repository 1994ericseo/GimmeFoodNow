//
//  JSONSerializationHelperTests.swift
//  GimmeFoodNowTests
//
//  Created by Eric Seo on 7/27/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import XCTest

class JSONSerializationHelperTests: XCTestCase {
    
    func testWithArrayFile() {
        
    }
    
    func testWithDictionaryFile() {
        guard let object = JSONSerializationHelper().getJSON(fileName: "ExampleYelpResponse") as? [String: Any] else {
            XCTFail()
            return
        }
        print(object)
    }
    
}
