//
//  RoomDetailEntityTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 10/14/24.
//

import XCTest
@testable import SantaManito_iOS

final class RoomDetailEntityTests: XCTestCase {

    override func setUp()  {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // 기획서 정렬 로직: 진행중 > 매칭 대기중 > 종료(결과 공개) > 기한 만료 > 방장에 의한 삭제
    func test_RoomState_정렬이_잘되는가() {
        let expected: [RoomState] = [.inProgress, .notStarted, .completed, .expired, .deleted]
        
        let states1 : [RoomState] = [.completed, .deleted, .expired, .inProgress, .notStarted]
        let states2 : [RoomState] = states1.reversed()
        
        XCTAssertEqual(states1.sorted(), expected)
        XCTAssertEqual(states2.sorted(), expected)
    }
    
    


}
