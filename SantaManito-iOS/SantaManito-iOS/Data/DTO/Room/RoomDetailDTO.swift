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
    let createdAt: String //TODO: 서버 확정 후 Date로 변경
    let expirationDate: String //TODO: 서버 확정 후 Date로 변경
    let matchingDate: String? //TODO: 서버 확정 후 Date로 변경
    let deletedByCreatorDate: String? //TODO: 서버 확정 후 Date로 변경
    let creator: UserResponse
    let missions: [MissionResponse]
    let members: [MemberResponse]
    
    enum CodingKeys: String, CodingKey {
            case id
            case roomName
            case invitationCode
            case createdAt
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
                          members: members.map { $0.toEntity()},
                          mission: missions.map { $0.toEntity()} ,
                          createdAt: Date().addingTimeInterval(-5 * 24 * 60 * 60), // TODO: 위 주석 해제하면 createdAt에 연결해야함.
                          expirationDate: Date().addingTimeInterval(-3 * 12 * 60 * 60)
        )
    }
}


