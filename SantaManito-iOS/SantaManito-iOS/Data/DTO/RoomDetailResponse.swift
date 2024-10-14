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
//    let createdAt: Date
    let expirationDate: Date
    let matchingDate: Date?
    let deletedByCreatorDate: Date?
    let creator: UserResponse
    let missions: [MissionResponse]
    let members: [MemberResponse]
    
    enum CodingKeys: String, CodingKey {
            case id
            case roomName
            case invitationCode
//            case createdAt
            case expirationDate
            case matchingDate
            case deletedByCreatorDate
            case creator = "Creator"
            case missions = "Missions"
            case members = "Members"
        }
}

extension RoomDetailResponse {
    func toEntity() -> RoomDetail {
        return RoomDetail(id: self.id, 
                          name: self.roomName,
                          invitationCode: self.invitationCode,
                          state: RoomStateFactory.create(self),
                          creatorID: self.creator.id,
                          creatorName: self.creator.username,
                          mission: missions.map { $0.toEntity()},
                          expirationDate: self.expirationDate,
                          members: members.map { $0.toEntity() }
        )
    }
}

struct RoomStateFactory {
    static func create(_ dto: RoomDetailResponse) -> RoomState {
        guard dto.deletedByCreatorDate == nil else { return .deleted }
        guard dto.expirationDate > Date() else { return .completed } //TODO: 서버와 클라의 TimeZone에 대한 논의 후 결정.
        guard dto.matchingDate != nil else { return .notStarted }
        return .inProgress
    }
}
