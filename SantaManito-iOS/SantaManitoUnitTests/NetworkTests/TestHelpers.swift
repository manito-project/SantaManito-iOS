////
////  TestHelpers.swift
////  SantaManito-iOS
////
////  Created by 류희재 on 8/11/25.
////
//
//import Testing
//import Foundation
//@testable import SantaManito_iOS
//
//// MARK: - Test Helpers
//
//struct TestData {
//    static let sampleRoomDetail = RoomDetailResponse(
//        id: "room-123",
//        roomName: "테스트 방",
//        invitationCode: "INVITE123",
//        createdAt: Date(),
//        expirationDate: Date().addingTimeInterval(86400),
//        matchingDate: nil,
//        deletedByCreatorDate: nil,
//        creator: UserResponse(id: "user-1", username: "테스트 유저"),
//        missions: [MissionResponse(id: "mission-1", content: "테스트 미션")],
//        members: [MemberResponse(santa: SantaUserResponse(id: "user-1", username: "테스트 유저", missionId: "mission-1"), manitto: nil)]
//    )
//    
//    static let sampleUser = UserResponse(id: "user-123", username: "테스트 사용자")
//    
//    static let sampleAuthResponse = AuthResponse(id: "user-123", accessToken: "test-token-123")
//}
//
//extension GenericResponse {
//    static func success<T>(_ data: T) -> GenericResponse<T> where T: Codable {
//        return GenericResponse(statusCode: 200, message: "Success", data: data)
//    }
//    
//    static func failure<T>(statusCode: Int, message: String) -> GenericResponse<T> where T: Codable {
//        return GenericResponse(statusCode: statusCode, message: message, data: nil)
//    }
//}
//
//extension GenericResponse where T: Codable {
//    init(statusCode: Int, message: String, data: T?) {
//        self.statusCode = statusCode
//        self.message = message
//        self.data = data
//    }
//}
