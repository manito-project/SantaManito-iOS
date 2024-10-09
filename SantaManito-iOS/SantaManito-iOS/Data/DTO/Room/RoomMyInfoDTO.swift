//
//  RoomMyInfoDTO.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/8/24.
//

import Foundation

struct RoomMyInfoResult: Decodable {
    var manitto: User
    var mission: Mission
}

extension RoomMyInfoResult {
    static let stub: RoomMyInfoResult  = .init(manitto: .stub1, mission: .stub)
}
