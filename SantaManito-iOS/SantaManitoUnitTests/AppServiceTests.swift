//
//  AppServiceTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/4/24.
//

import XCTest
@testable import SantaManito_iOS

final class AppServiceTests: XCTestCase {

    var sut : AppService!
    
    override func setUp() {
        sut = AppService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - 로컬 앱 버전 바뀔 시 테스트에 실패할 수 있음.
    func test_로컬버전을_잘_가져오는가()  {
        let localVersion = sut.getLocalAppVersion()
        let expected = Version("2.0.0")
        XCTAssertEqual(localVersion, expected)
    }
    
    //MARK: - 앱스토어 앱 버전 바뀔 시 테스트에 실패할 수 있음.
    func test_앱스토어버전을_잘_가져오는가()  {
        let appStoreVersion = sut.getAppStoreVersion()
        let expected = Version("1.2.2")
        XCTAssertEqual(appStoreVersion, expected)
    }


}
