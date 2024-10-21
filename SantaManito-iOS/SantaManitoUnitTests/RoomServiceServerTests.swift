//
//  RoomServiceServerTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/11/24.
//

import XCTest

@testable import SantaManito_iOS

final class RoomServiceServerTests: XCTestCase {
    
    var sut : RoomServiceType!
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        sut = RoomService()
        
        UserDefaultsService.shared.accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFlYjg0Yzg3LWNkZmEtNDBhMS1hNGY3LTI1YTQwOTNjMDcyMCIsImlhdCI6MTcyODYyMTcxMywiZXhwIjoxNzM2Mzk3NzEzfQ.7kdOdP5YxtkIzXa2TMYgifcUWjoQI7it71u8KM-Paok"
    }
    
    override func tearDown() {
        cancelBag = nil
        sut = nil
    }
    
    
    func test_방목록전체조회_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getEnteredRooms()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.description)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_방상세조회_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getRoomInfo(with: "f037c558-6589-4ad8-b056-feee994410d4")
            .sink { completion in
                expectation.fulfill()
                
                guard case let .failure(err) = completion
                else { return }
                
                
                guard case let SMNetworkError.invalidResponse(responseError) = err
                else { XCTFail(err.description); return }
                
                
                guard case .invalidStatusCode = responseError 
                else { XCTFail(responseError.description); return }
               
            } receiveValue: { roomDetails in
                print("🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏")
                print(roomDetails)
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
}
