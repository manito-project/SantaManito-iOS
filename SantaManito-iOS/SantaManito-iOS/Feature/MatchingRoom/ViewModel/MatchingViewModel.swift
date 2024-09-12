//
//  MatchingViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import Foundation
import Combine

class MatchingResultViewModel: ObservableObject {
    
    //MARK: Action
    
    enum Action {
        case load
        case goHomeButtonClicked
    }
    
    @Published private(set) var state = State(
        me: "이영진",
        manito: "이한나",
        mission: "5천원 이하의 선물과 함께 카톡으로 수고했다고",
        room: Room(name: "마니또 방", remainingDats: 3, endData: Date())
    )
    
    //MARK: State
    
    struct State {
        var me: String //TODO: 나를 표시해야함
        var manito: String //TODO: 나중에 User로 변경해야됨
        var mission: String //TODO: 이것도 나중에 Entity 고민
        var room: Room //TODO: 나중에 서버통신으로 변경해야됨
    }
    
    //MARK: send
    
    func send(action: Action) {
        switch action {
        case .load:
            break
            //TODO: 마니또 매칭된 사람 및 방 정보를 가져와야 함
        case .goHomeButtonClicked:
            break
            //TODO: 홈 화면으로 전환
        }
    }
}
