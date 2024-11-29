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
    
    var me: Member {
        members.filter { $0.santa.id == UserDefaultsService.shared.userID}.first ?? .init(santa: .stub1, manitto: .stub1)
    }
    
    var myMission: Mission? {
        mission.filter { $0.id == me.santa.missionId }.first
    }

}

extension RoomDetail: Comparable {
    
/// 1. 방 상태별 정렬 로직
/// 게임 참여중(진행중 > 매칭 대기중) > 게임 참여 불가(종료 > 만료) > 삭제 및 나가기(방장에 의해 삭제된 방)
///
/// 2. 방 상태가 동일한 경우 우선 순위
/// i. 진행중: ’결과 공개 예정일’ 기준 오름차순(’공개 n일 전’의 n이 작을 수록 상위 노출)
/// ii. 매칭 대기중:방장의 방 생성 일자 내림차순(최신 생성 방 상위 노출)
/// iii. 종료(결과 공개): 방 종료 일자 내림차순(최근 종료된 방이 상위 노출) 
/// iv. 기한 만료: 방장의 방 생성 일자 내림차순(최신 생성 방 상위 노출) 
/// v. 방장에 의해 삭제된 방:방 생성 일자 내림차순(최신 생성 방 상위 노출)
/// vi. 나가기 처리: 비노출
///
/// 결론: 진행중 > 매칭 대기중 > 종료(결과 공개) > 기한 만료 > 방장에 의한 삭제
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.state == rhs.state else { return lhs.state < rhs.state }
        switch lhs.state {
        case .inProgress: return lhs.expirationDate < rhs.expirationDate
        case .notStarted: return lhs.createdAt > rhs.createdAt
        case .completed: return lhs.expirationDate < rhs.expirationDate
        case .expired: return lhs.createdAt > rhs.createdAt
        case .deleted: return lhs.createdAt > rhs.createdAt
        }
        
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
              creatorID: UserDefaultsService.shared.userID,
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
              mission: [.stub1,
                        .stub2,
                        .stub3,
                        .stub4],
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
              mission: [.stub1,
                        .stub2,
                        .stub3,
                        .stub4],
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
              mission: [.stub1,
                        .stub2,
                        .stub3,
                        .stub4],
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
              mission: [.stub1,
                        .stub2,
                        .stub3,
                        .stub4],
              createdAt: Date(),
              expirationDate: Date()
              )
    }
}
