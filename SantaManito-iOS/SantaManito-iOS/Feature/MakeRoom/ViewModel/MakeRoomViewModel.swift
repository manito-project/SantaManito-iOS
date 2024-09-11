//
//  MakeRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import Foundation
import Combine

class MakeRoomViewModel: ObservableObject {
    
    //MARK: Action
    enum Action {
        case load // 방이름 작성
        case configRoomName(String) // 방이름 작성
        case increaseDuedate // 마니또 마감 날짜 늘리기
        case decreaseDuedate // 마니또 마감 날짜 줄이기
        case configDuedateTime(Date) // 마니또 종료 시간 설정
        case noMissionButtonClicked // 미션없이 방을 생성하려고 할때
        case missionButtonClicked // 미션 설정 후 방을 생성하려고 할때
    }
    
    @Published var roomName: String = "" // 방 이름
    @Published var remainingDays: Int = 3 // 마감일자까지 남은 날짜
    @Published var dueDateTime: Date = Date() // 마감일자 (마니또 공개일)
    
    @Published private(set) var state = State(
        isEnabled: false,
        canIncreaseDays: true,
        canDecreaseDays: true,
        dueDate: Date().toDueDateAndTime
    )
    
    struct State {
        var isEnabled: Bool
        var canIncreaseDays: Bool
        var canDecreaseDays: Bool
        var dueDate: String
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            checkRemainingDaysInRange()
            configDuedata()
            
        case .configRoomName(let name):
            roomName = name.count >= 17 ? String(name.prefix(17)) : name
            configButtonisEnabled()
            
        case .increaseDuedate:
            if state.canIncreaseDays {
                remainingDays += 1
            }
            checkRemainingDaysInRange()
            configDuedata()
            
        case .decreaseDuedate:
            if state.canDecreaseDays {
                remainingDays -= 1
            }
            checkRemainingDaysInRange()
            configDuedata()
            
        case .configDuedateTime(let dueDateTime):
            self.dueDateTime = dueDateTime
            configDuedata()
            
        case .noMissionButtonClicked:
            print("noMissionButtonClicked")
            //미션 미설정 확인 모달 보여주고 거기서도 okay하면 바로 방 확정짓는 파일로 넘어가기
        case .missionButtonClicked:
            //미션 만드는 화면으로 넘어가
            print("missionButtonClicked")
        }
    }
}

extension MakeRoomViewModel {
    /// 남은 기한을 3~14일 사이로 설정가능한지 확인하는 함수
    func checkRemainingDaysInRange() {
        state.canIncreaseDays = remainingDays >= 14 ? false: true
        state.canDecreaseDays = remainingDays <= 3 ? false: true
    }
    
    ///마니또 공개일을 계산하는 함수
    func configDuedata() {
        let addingDate = Date().addingDays(remainingDays: remainingDays)
        state.dueDate = addingDate.toDueDate + " " + dueDateTime.toDueDateTime
    }
    
    func configButtonisEnabled() {
        state.isEnabled = !roomName.isEmpty
    }
}

