//
//  VersionEntityTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/4/24.
//

import XCTest
@testable import SantaManito_iOS

final class VersionEntityTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func test_문자열을_버전으로_잘_변환하는가() {
        // Given
        let versionString = "1.0.0"
        
        // When
        let version = Version(versionString)
        
        //Then
        let expectedMajor = 1
        let expectedMinor = 0
        let expectedPatch = 0
        
        XCTAssertEqual(version.major, expectedMajor)
        XCTAssertEqual(version.minor, expectedMinor)
        XCTAssertEqual(version.patch, expectedPatch)
    }
    
    func test_대소비교가_정상작동_하는가() {
        // Given
        let a = Version("2.0.1")
        let b = Version("1.10.2")
        let c = Version("1.10.0")
        let c2 = Version("1.10.0")
        let d = Version("1.0.10")
        
        let expected = [a,b,c,c2,d]
        // Then
        XCTAssertEqual([a,b,c,c2,d].sorted(by: >), expected)
    }



}
