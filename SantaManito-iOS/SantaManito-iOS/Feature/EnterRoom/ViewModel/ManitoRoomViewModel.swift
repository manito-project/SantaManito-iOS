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
        isEnabled: false
    )
    
    //MARK: State
    
    struct State {
        var isEnabled: Bool
    }
    
    //MARK: send
    
    func send(action: Action) {
        switch action {
        case .load:
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
        }
    }
}
