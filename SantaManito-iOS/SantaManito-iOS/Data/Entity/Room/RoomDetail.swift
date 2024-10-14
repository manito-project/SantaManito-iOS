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
    let members: [Member]
    var mission: [Mission]
    let createdAt: Date
    let expirationDate: Date
    
    
    var isHost: Bool {
        UserDefaultsService.userID == creatorID
    }
    
    var remainingDays: Int {
        return Date().daysBetween(expirationDate) //TODO: 0일 및 24시간이 제대로 동작하는지 확인 필요
    }
    
    var expirationDateToString: String {
        expirationDate.toDueDateWithoutYear
    }
}

extension RoomDetail {
    
    //TODO: remainingDays: 0일 및 24시간이 제대로 동작하는지 확인 필요
    
    func toMakeRoomInfo() -> MakeRoomInfo {
        .init(
            name: self.name,
            remainingDays: self.createdAt.daysBetween(expirationDate),
            dueDate: self.expirationDate
        )
    }
}



extension RoomDetail {
    static var stub1: Self {
        .init(id: "roomID1",
              name: "크리스마스 마니또",
              invitationCode: "초대코드1",
              state: .notStarted,
              creatorID: User.stub1.id,
              creatorName: User.stub1.username,
              members: .stub1,
              mission: [],
              createdAt: Date(),
              expirationDate: Date()
        )
    }
    
    static var stub2: Self {
        .init(id: "roomID2",
              name: "크리스마스 마니또",
              invitationCode: "초대코드2",
              state: .inProgress,
              creatorID: User.stub1.id,
              creatorName: User.stub1.username,
              members: .stub2,
              mission: [],
              createdAt: Date(),
              expirationDate: Date()
              )
    }
     
    
    static var stub3: Self {
        .init(id: "roomID3",
              name: "크리스마스 마니또",
              invitationCode: "초대코드3",
              state: .inProgress,
              creatorID: User.stub2.id,
              creatorName: User.stub2.username,
              members: .stub2,
              mission: [],
              createdAt: Date(),
              expirationDate: Date()
              )
    }
    
    
    static var stub4: Self {
        .init(id: "roomID4",
              name: "크리스마스 마니또",
              invitationCode: "초대코드4",
              state: .completed,
              creatorID: User.stub1.id,
              creatorName: User.stub1.username,
              members: .stub3,
              mission: [],
              createdAt: Date(),
              expirationDate: Date()
              )
    }
    
    
    static var stub5: Self {
        .init(id: "roomID5",
              name: "크리스마스 마니또",
              invitationCode: "초대코드5",
              state: .deleted,
              creatorID: User.stub1.id,
              creatorName: User.stub1.username,
              members: .stub3,
              mission: [],
              createdAt: Date(),
              expirationDate: Date()
              )
    }
}
