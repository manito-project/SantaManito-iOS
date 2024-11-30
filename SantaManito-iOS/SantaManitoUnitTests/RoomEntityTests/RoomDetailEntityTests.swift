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
    
    func test_나를_잘_찾는가() {
        
        // Given
        UserDefaultsService.shared.userID = "test_user_id_1"
        
        let santa1 = SantaUser(id: "test_user_id_1", username: "나", missionId: nil)
        let manitto1 = User(id: "test_user_id_2", username: "너")
        
        let santa2 = SantaUser(id: "test_user_id_2", username: "너", missionId: nil)
        let manitto2 = User(id: "test_user_id_1", username: "나")
        
        let member1 = Member(santa: santa1, manitto: manitto1) // 나
        let member2 = Member(santa: santa2, manitto: manitto2) // 너
        
        // When
        let roomDetail = RoomDetail(
            id: "",
            name: "",
            invitationCode: "",
            state: .completed,
            creatorID: "test_user_id_1",
            creatorName: "",
            members: [member1, member2],
            mission: [],
            createdAt: Date(),
            expirationDate: Date())
        
        // Then
        XCTAssertEqual(roomDetail.me, member1) // 
    }
    
    func test_나의_미션을_잘_찾는가() {
        
        // Given
        UserDefaultsService.shared.userID = "test_user_id_1"
        
        let santa1 = SantaUser(id: "test_user_id_1", username: "나", missionId: "mission_id_1")
        let manitto1 = User(id: "test_user_id_2", username: "너")
        let mission1 = Mission(content: "나의 미션", id: "mission_id_1")
        
        let santa2 = SantaUser(id: "test_user_id_2", username: "너", missionId: "mission_id_2")
        let manitto2 = User(id: "test_user_id_1", username: "나")
        let mission2 = Mission(content: "너의 미션", id: "mission_id_2")
        
        let member1 = Member(santa: santa1, manitto: manitto1) // 나
        let member2 = Member(santa: santa2, manitto: manitto2) // 너
        
        // When
        let roomDetail = RoomDetail(
            id: "",
            name: "",
            invitationCode: "",
            state: .completed,
            creatorID: "test_user_id_1",
            creatorName: "",
            members: [member1, member2],
            mission: [mission1, mission2],
            createdAt: Date(),
            expirationDate: Date())
        
        // Then
        XCTAssertEqual(roomDetail.myMission, mission1)
    }
    
    
    
}
