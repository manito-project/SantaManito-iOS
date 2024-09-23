//
//  RoomDetailResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/23/24.
//

import Foundation

struct RoomDetailResponse: Decodable {
    let id: String
    let roomName: String
    let invitationCode: String
    let createdAt: String
    let expirationDate: String
    let matchingDate: String?
    let deletedByCreatorDate: String?
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
                          expirationDate: self.expirationDate
        )
    }
}

struct RoomStateFactory {
    static func create(_ dto: RoomDetailResponse) -> RoomState {
        guard dto.deletedByCreatorDate != nil else { return .deleted }
        guard dto.expirationDate > "현재시간보다" else { return .completed } //TODO: 현재 시간보다 로직
        guard dto.matchingDate != nil else { return .notStarted }
        return .inProgress
    }
}
