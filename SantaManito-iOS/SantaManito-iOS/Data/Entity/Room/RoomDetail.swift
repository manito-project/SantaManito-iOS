//
//  RoomDetail.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/23/24.
//

import Foundation

struct RoomDetail: Hashable {
    var id: String
    var name: String
    let invitationCode: String
    var state: RoomState
    var creatorID: String
    var creatorName: String
    var mission: [Mission]
    let expirationDate: String
    
    var isHost: Bool {
        "유저디폴트ID" == creatorID //TODO: 로그인시 유저디폴트에 저장로직 
    }
    var remainingDays: String {
        "expirationDate-오늘 로직" //TODO: 만료일 - 오늘 로직
    }
}

extension RoomDetail {
    static var stub: Self {
        .init(id: "id", name: "장석우", invitationCode: "초대코드stub1", state: .notStarted, creatorID: "creatorID1", creatorName: "creatorName1", mission: [], expirationDate: "2024-09-24")
    }
}
