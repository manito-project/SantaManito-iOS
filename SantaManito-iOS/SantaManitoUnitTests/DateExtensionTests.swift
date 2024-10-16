//
//  DateParsingTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/14/24.
//

import XCTest

@testable import SantaManito_iOS

final class DateParsingTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_iso형식이_맞는가() {
        // Given
        let dateString = "2000-04-15T11:13:00Z"
        let formatter = ISO8601DateFormatter()
        
        
        
        // When
        let date = formatter.date(from: dateString)
        
        // Then
        XCTAssertTrue(date != nil)
    }
    
    func test_custom형식으로_iso형식을_파싱이_가능한가() {
        
        // Given
        let dateString = "2000-04-15T11:13:00Z"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        
        
        // When
        let date = formatter.date(from: dateString)
        
        //Then
        XCTAssertTrue(date != nil)
    }
    
    //MARK: - UTC +9 기준
    
    func test_between함수는_UTC_9날짜를_한국날짜_기준으로_1일후를_반환하는가() {
        
        // Given
        let startString = "2024-01-01T14:00:00+09:00"
        let endString = "2024-01-02T14:00:00+09:00"
        
        let formatter = ISO8601DateFormatter()
        let start = formatter.date(from: startString)!
        let end = formatter.date(from: endString)!
        
        // When
        let remainingDays = start.daysBetweenInSeoulTimeZone(end)
        
        // Then
        XCTAssertEqual(remainingDays, 1)
    }
    
    func test_between함수는_UTC_9날짜_2분_차이여도_한국_날짜를_기준으로_1일후를_반환하는가() {
        
        // Given
        let startString = "2024-01-01T23:59:00+09:00" // 23시 59분
        let endString = "2024-01-02T00:01:00+09:00" // 00시 01분
        
        let formatter = ISO8601DateFormatter()
        let start = formatter.date(from: startString)!
        let end = formatter.date(from: endString)!
        
        // When
        let remainingDays = start.daysBetweenInSeoulTimeZone(end)
        
        // Then
        XCTAssertEqual(remainingDays, 1)
    }
    
    
    //MARK: - UTC 기준
    
    func test_between함수는_UTC_날짜를_한국날짜_기준으로_1일후를_반환하는가() {
        
        // Given
        let startString = "2024-01-01T14:00:00z"
        let endString = "2024-01-02T14:00:00z"
        
        let formatter = ISO8601DateFormatter()
        let start = formatter.date(from: startString)!
        let end = formatter.date(from: endString)!
        
        // When
        let remainingDays = start.daysBetweenInSeoulTimeZone(end)
        
        // Then
        XCTAssertEqual(remainingDays, 1)
    }
    
    func test_between함수는_UTC_날짜가_달라도_한국_날짜를_기준으로_1일후를_반환하지_않는가() {
        
        // Given
        let startString = "2024-01-01T23:59:00z" // 23시 59분
        let endString = "2024-01-02T00:01:00z" // 00시 01분
        
        let formatter = ISO8601DateFormatter()
        let start = formatter.date(from: startString)!
        let end = formatter.date(from: endString)!
        
        // When
        let remainingDays = start.daysBetweenInSeoulTimeZone(end)
        
        // Then
        XCTAssertNotEqual(remainingDays, 1)
    }
    
}
