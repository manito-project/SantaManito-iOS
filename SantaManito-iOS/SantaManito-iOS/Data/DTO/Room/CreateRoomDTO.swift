//
//  CreateRoomRequest.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//

import Foundation

struct CreateRoomRequest: Encodable {
    var roomName: String
    var expirationDate: Date
    var missionContents: [String]
}

extension CreateRoomRequest {
    init(_ room: MakeRoomInfo, _ mission: [Mission]) {
        self.roomName = room.name
        self.expirationDate = room.expirationDate
        self.missionContents = mission.map { $0.content } // TODO: 미션로직 수정필요하다면
    }
}

struct CreateRoomResult: Decodable {
    var invitationCode: String
}
