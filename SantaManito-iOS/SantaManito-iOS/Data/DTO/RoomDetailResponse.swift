//
//  RoomDetailResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/23/24.
//

import Foundation

struct RoomDetailTestReseponse: Decodable {
    let createdAt: Date
}

struct RoomDetailResponse: Decodable {
    let id: String
    let roomName: String
    let invitationCode: String
    let createdAt: Date
    let expirationDate: Date
    let matchingDate: Date?
    let deletedByCreatorDate: Date?
    let Creator: UserResponse
    let Missions: [MissionResponse]
    let Members: [UserResponse]
}

extension RoomDetailResponse {
    func toEntity() -> RoomDetail {
        return RoomDetail(id: self.id, 
                          name: self.roomName,
                          invitationCode: self.invitationCode,
                          state: RoomStateFactory.create(self),
                          creatorID: self.Creator.id,
                          creatorName: self.Creator.username,
                          mission: Missions.map { $0.toEntity()},
                          expirationDate: self.expirationDate,
                          members: Members.map { $0.toEntity() }
        )
    }
}

struct RoomStateFactory {
    static func create(_ dto: RoomDetailResponse) -> RoomState {
        guard dto.deletedByCreatorDate != nil else { return .deleted }
        guard dto.expirationDate > Date() else { return .completed } //TODO: 서버와 클라의 TimeZone에 대한 논의 후 결정.
        guard dto.matchingDate != nil else { return .notStarted }
        return .inProgress
    }
}
