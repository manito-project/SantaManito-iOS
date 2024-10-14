//
//  DateParsingTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/14/24.
//

import XCTest

final class DateParsingTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_isoTest() {
        // Given
        let formatter = ISO8601DateFormatter()
        let dateString = "2000-04-15T11:13:00Z"
        
        
        // When
        let date = formatter.date(from: dateString)
        
        XCTAssertTrue(date != nil)
    }
    
    func test_custom_Test() {
        // Given
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        let dateString = "2000-04-15T11:13:00Z"
        
        
        // When
        let date = formatter.date(from: dateString)
        
        XCTAssertTrue(date != nil)
    }
}
