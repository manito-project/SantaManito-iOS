//
//  SantaManitoUnitTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/1/24.
//

import XCTest
@testable import SantaManito_iOS
@testable import FirebaseCore

//MARK: Deprecated - FirebaseRemoteConfig는 AppDelegate의 생명주기에 따라 동작하기에 테스트 코드 실행 불가했음 (2024.10.01) by melt
//final class SantaManitoUnitTests: XCTestCase {
//    
//    var sut = FirebaseRemoteConfigService.shared
//    var cancelBag: CancelBag!
//    
//    override func setUp() {
//        FirebaseApp.configure()
//        cancelBag = CancelBag()
//    }
//
//    override func tearDown() {
//        cancelBag = nil
//    }
//
//    func test_서버체크가_값을_받아오는가() {
//        
//        let expectation = XCTestExpectation(description: "server_check_값 테스트")
//        let expectedValue = true
//        
//        sut.getServerCheck()
//            .sink { completion in
//                if case let .failure(err) = completion {
//                    XCTFail(err.localizedDescription)
//                }
//            } receiveValue: { serverCheck in
//                expectation.fulfill()
//                XCTAssertEqual(serverCheck, expectedValue)
//            }
//            .store(in: cancelBag)
//
//        
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
//
//
//}
