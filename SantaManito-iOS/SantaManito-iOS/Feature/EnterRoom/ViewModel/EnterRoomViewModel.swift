//
//  EnterRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import Foundation
import Combine

class EnterRoomViewModel: ObservableObject {
    
    //MARK: Action
    
    enum Action {
        case editInviteCode
        case enterButtonDidClicked
    }
    
    @Published var inviteCode: String = ""
    
    @Published private(set) var state = State(
        isEnabled: false,
        canPush: false,
        isValid: true,
        errMessage: "이미 참여중인 방입니다!"
    )
    
    //MARK: State
    
    struct State {
        var isEnabled: Bool
        var canPush: Bool // 다음 화면으로 넘어갈 수 있는지를 나타내는 상태값
        var isValid: Bool // 에러가 있는지 없는지 즉, 초대코드가 유효한지 근데 이걸 errMessage로 구분할지 애매한 상황
        var errMessage: String
    }
    
    //MARK: send
    
    func send(action: Action) {
        switch action {
        case .editInviteCode:
            configButtonisEnabled()
        case .enterButtonDidClicked:
            //TODO: 초대코드 유효성 검사
            configisValid()
        }
    }
}

extension EnterRoomViewModel {
    func configButtonisEnabled() {
        state.isEnabled = !inviteCode.isEmpty
    }
    
    func configisValid() {
        state.isValid = !state.errMessage.isEmpty
    }

}
