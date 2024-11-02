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
        UserDefaultsService.shared.userID == creatorID
    }
    
    // 오늘부터 만료일까지 (한국 날짜 기준)
    var remainingDays: Int {
        return Date().daysBetweenInSeoulTimeZone(expirationDate)
    }
    
    // 생성일부터 만료일까지 (한국 날짜 기준)
    var totalDurationDays: Int {
        return createdAt.daysBetweenInSeoulTimeZone(expirationDate)
    }
    
    var expirationDateToString: String {
        expirationDate.toDueDateWithoutYear
    }
}

extension RoomDetail {
    
    func toMakeRoomInfo() -> MakeRoomInfo {
        .init(
            createdAt: createdAt,
            name: self.name,
            totalDurationDays: self.totalDurationDays,
            dueDate: self.expirationDate
        )
    }
}



extension RoomDetail {
    static var stub1: Self {
        .init(id: "roomID1",
              name: "한",
              invitationCode: "초대코드1",
              state: .notStarted,
              creatorID: User.stub1.id,
              creatorName: User.stub1.username,
              members: .stub1,
              mission: [
                .stub1,
                .stub2,
                .stub3,
                .stub4
              ],
              createdAt: Date(),
              expirationDate: Date()
        )
    }
    
    static var stub2: Self {
        .init(id: "roomID2",
              name: "두글",
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
              name: "12345678901234567",
              invitationCode: "초대코드3",
              state: .expired,
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
              name: "크리스마스 마니또크리스마스 마니또",
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
