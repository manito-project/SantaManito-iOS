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
    let expirationDate: Date
    let members: [User]
    
    var isHost: Bool {
        "userID1" == creatorID //TODO: 로그인시 유저디폴트에 저장로직
    }
    var remainingDays: String {
        "expirationDate-오늘 로직" //TODO: 만료일 - 오늘 로직
    }
    
    var expirationDateToString: String {
        expirationDate.toDueDateWithoutYear
    }
}

extension RoomDetail {
    func toMakeRoomInfo() -> MakeRoomInfo {
        //TODO: remainingDays = (self.expirationDate - Date()) 로직
        
        .init(name: self.name,
              remainingDays: 3,
              dueDate: self.expirationDate)
    }
}


extension RoomDetail {
    static var stub: Self {
        .init(id: "roomID1",
              name: "크리스마스 마니또",
              invitationCode: "초대코드stub1",
              state: .notStarted,
              creatorID: User.stub1.id,
              creatorName: User.stub1.username,
              mission: [],
              expirationDate: Date(), 
              members: [.stub1, .stub2, .stub3, .stub4])
    }
}
