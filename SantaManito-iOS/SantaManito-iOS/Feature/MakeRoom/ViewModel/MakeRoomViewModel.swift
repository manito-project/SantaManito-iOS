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
        case configRoomName // 방이름 작성
        case xButtonClicked // 텍스트 필드 안에 x버튼 눌렸을 때
        case configEndDate // 마니또 종료일 설정
        case configEndTime // 마니또 종료 시간 설정
        case backButtonClicked // backButton을 눌렀을 때 (이거 위치 어디로 할지 고민)
        case noMissionButtonClicked // 미션없이 방을 생성하려고 할때
        case missionButtonClicked // 미션 설정 후 방을 생성하려고 할때
    }
    
    struct State {
        var room: Room
    }
    
    @Published private(set) var state = State(
        room: .init(name: "", endData: Date(), endTime: Date())
    )
    
    
    
    func send(action: Action) {
        switch action {
        case .configRoomName:
            break
            // 17자까지만 입력 가능하도록
            // state room에 name 반영하기
        case .xButtonClicked:
            break
            // room의 name값 clear 하기
        case .configEndDate:
            break
            // 버튼을 누를때마다 변경사항을 반영한다.
            // 3~30일 넘으려고 하면 버튼 비활성화 시킨다.
        case .configEndTime:
            // TimePicker을 통해서 시간 설정
            // AM / PM을 따로 설정
            break
        case .backButtonClicked:
            break
            // Main 화면으로 돌아간다
        case .noMissionButtonClicked:
            break
            //미션 미설정 확인 모달 보여주고 거기서도 okay하면 바로 방 확정짓는 파일로 넘어가기
        case .missionButtonClicked:
            //미션 만드는 화면으로 넘어가
            break
        }
    }
       
}

