//
//  FinishViewModelTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 11/30/24.
//

import Foundation
import XCTest

@testable import SantaManito_iOS

final class FinishViewModelTests: XCTestCase {
    
    var roomService: RoomServiceType!
    var navigationRouter: NavigationRoutableType!
    
    override func setUp()  {
        self.roomService = StubRoomService()
        self.navigationRouter = NavigationRouter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_나의산타를_잘_반환하는가() {
        // Given
        UserDefaultsService.shared.userID = "test_user_id_1"
        
        // 나
        let mission1 = Mission(content: "나의 미션", id: "mission_id_1")
        let santa1 = SantaUser(id: "test_user_id_1", username: "나", missionId: "mission_id_1")
        let manitto1: User = User(id: "test_user_id_2", username: "너")
        let member1 = Member(santa: santa1, manitto: manitto1)
        
        // 너
        let mission2 = Mission(content: "너의 미션", id: "mission_id_2")
        let santa2 = SantaUser(id: "test_user_id_2", username: "너", missionId: "mission_id_2")
        let manitto2 = User(id: "test_user_id_1", username: "나")
        let member2 = Member(santa: santa2, manitto: manitto2) // 너
        
        // When
        let roomDetail = RoomDetail(
            id: "",
            name: "",
            invitationCode: "",
            state: .completed,
            creatorID: "",
            creatorName: "",
            members: [member1, member2],
            mission: [mission1, mission2],
            createdAt: Date(),
            expirationDate: Date()
        )
        
        let sut = FinishViewModel(roomService: roomService, navigationRouter: navigationRouter, roomInfo: roomDetail)
        
        XCTAssertEqual(sut.state.mySanta, member2)
    }
    
    func test_나의_산타의_미션을_잘_찾는가() {
        // Given
        UserDefaultsService.shared.userID = "test_user_id_1"
        
        // 나
        let mission1 = Mission(content: "나의 미션", id: "mission_id_1")
        let santa1 = SantaUser(id: "test_user_id_1", username: "나", missionId: "mission_id_1")
        let manitto1: User = User(id: "test_user_id_2", username: "너")
        let member1 = Member(santa: santa1, manitto: manitto1)
        
        // 너
        let mission2 = Mission(content: "너의 미션", id: "mission_id_2")
        let santa2 = SantaUser(id: "test_user_id_2", username: "너", missionId: "mission_id_2")
        let manitto2 = User(id: "test_user_id_1", username: "나")
        let member2 = Member(santa: santa2, manitto: manitto2) // 너
        
        // When
        let roomDetail = RoomDetail(
            id: "",
            name: "",
            invitationCode: "",
            state: .completed,
            creatorID: "",
            creatorName: "",
            members: [member1, member2],
            mission: [mission1, mission2],
            createdAt: Date(),
            expirationDate: Date()
        )
        
        let sut = FinishViewModel(roomService: roomService, navigationRouter: navigationRouter, roomInfo: roomDetail)
        
        XCTAssertEqual(sut.state.mySantaMission, mission2.content)
    }
    
    
}
