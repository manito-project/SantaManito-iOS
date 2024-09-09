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
        case configRoomName(String) // 방이름 작성
        case increaseDuedate // 마니또 마감 날짜 늘리기
        case decreaseDuedate // 마니또 마감 날짜 줄이기
        case configEndTime // 마니또 종료 시간 설정
        case configAmorPm(Bool) // 오전인지 오후인지 정하기
        case backButtonClicked // backButton을 눌렀을 때 (이거 위치 어디로 할지 고민)
        case noMissionButtonClicked // 미션없이 방을 생성하려고 할때
        case missionButtonClicked // 미션 설정 후 방을 생성하려고 할때
    }
    
    @Published var roomName: String = "" // 방 이름
    @Published var remainingDays: Int = 5 // 마감일자까지 남은 날짜
    @Published var dueDate: Date = Date() // 마감일자 (마니또 공개일)
    
    @Published var canDecreaseRemainingDays: Bool = true
    @Published var canIncreaseRemainingDays: Bool = true
    
    
    
    func send(action: Action) {
        switch action {
        case .configRoomName(let name):
            if name.count >= 17 {
                roomName = String(name.prefix(17))
            } else {
                roomName = name
            }
            
            print("방 제목은 \(roomName)이며, \(roomName.count)입니다!")
        case .increaseDuedate:
            if canIncreaseRemainingDays {
                remainingDays += 1
            }
            checkRemainingDaysInRange()
        case .decreaseDuedate:
            if canDecreaseRemainingDays {
                remainingDays -= 1
            }
            checkRemainingDaysInRange()
        case .configEndTime:
            // TimePicker을 통해서 시간 설정
            break
        case .configAmorPm:
            break
            // AM / PM을 따로 설정
        case .backButtonClicked:
            print("backButtonClicked")
            // Main 화면으로 돌아간다
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
        canIncreaseRemainingDays = remainingDays >= 14 ? false: true
        canDecreaseRemainingDays = remainingDays <= 3 ? false: true
    }
}
