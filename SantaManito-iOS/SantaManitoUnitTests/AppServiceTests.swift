//
//  AppServiceTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/4/24.
//

import XCTest
import Combine
@testable import SantaManito_iOS

final class AppServiceTests: XCTestCase {

    var sut : AppService!
    var cancelBag: CancelBag!
    
    override func setUp() {
        
        sut = AppService()
        cancelBag = CancelBag()
    }

    override func tearDown() {
        
        sut = nil
        cancelBag = nil
    }

    //MARK: - 로컬 앱 버전 바뀔 시 테스트에 실패할 수 있음.
    func test_로컬버전을_잘_가져오는가()  {
        let localVersion = sut.getLocalAppVersion()
        let expected = Version("2.0.0")
        XCTAssertEqual(localVersion, expected)
    }
    
    //MARK: - 앱스토어 앱 버전 바뀔 시 테스트에 실패할 수 있음.
    
    func test_앱스토어버전을_잘_가져오는가() {
        
        let expectation = XCTestExpectation(description: "server_check_값 테스트")
        
        sut.getAppStoreVersion()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return 
                case .failure(let failure):
                    XCTFail(failure.localizedDescription)
                }
            }, receiveValue: { version in
                expectation.fulfill()
                XCTAssertTrue(true)
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
    }


}
