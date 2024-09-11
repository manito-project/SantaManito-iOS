//
//  ManitoRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import Foundation
import Combine

/// 임시 유저 struct
struct Participate: Hashable, Identifiable {
    var name: String
    var id = UUID()
}

class ManitoRoomViewModel: ObservableObject {
    
    //MARK: Action
    
    enum Action {
        case load
        case refreshParticipant
        case copyInviteCode
        case matchingButtonClicked
        case editRoomInfo // 방 수정하기 뷰로 넘어감
    }
    
    @Published var inviteCode: String = ""
    //TODO: 나중에 유저에 대한 타입으로 수정
    @Published var participantList: [Participate] = [
        Participate(name: "류희재"),
        Participate(name: "류희재"),
        Participate(name: "류희재"),
        Participate(name: "류희재"),
        Participate(name: "류희재"),
        Participate(name: "류희재"),
        Participate(name: "류희재")
    ]
    
    @Published private(set) var state = State(
        isEnabled: false,
        isLeader: true,
        description: ""
    )
    
    //MARK: State
    
    struct State {
        var isEnabled: Bool
        var isLeader: Bool
        var description: String
    }
    
    //MARK: send
    
    func send(action: Action) {
        switch action {
        case .load:
            configDescription()
            //TODO: 참가자 정보 불러오기
            break
        case .refreshParticipant:
            //TODO: 참가자 정보 불러오기
            break
        case .copyInviteCode:
            //TODO: 초대코드 복사하기
            break
        case .matchingButtonClicked:
            //TODO: 매칭시작하기
            break
        case .editRoomInfo:
            //TODO: 방 수정하기 뷰로 넘어감
            break
        }
    }
}

extension ManitoRoomViewModel {
    func configDescription() {
        state.description = state.isLeader ? "방장 산타는 참여자가 다 모이면 마니또 매칭을 해줘!" : "방장 산타가 마니또 매칭을 할 때까지 기다려보자!"
    }
}
