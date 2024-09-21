//
//  EnterRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//


import Foundation
import Combine

class EnterRoomViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case editInviteCode
        case enterButtonDidClicked
    }
    struct State {
        var isEnabled: Bool = false //MARK: 히디의 고민: isEnabled라는 변수명이 너무 모호함 (초대코드에 텍스트가 있으면 버튼을 누를 수 있도록 하는 역할)
        var canPush: Bool = false // 다음 화면으로 넘어갈 수 있는지를 나타내는 상태값 //MARK: 히디의 고민: canPush 조금 이상한? 느낌 ㅠ
        var isValid: Bool = true // 에러가 있는지 없는지 즉, 초대코드가 유효한지 근데 이걸 errMessage로 구분할지 애매한 상황
        var errMessage: String = ""
    }
    
    //MARK: Dependency
    
    var roomService: EnterRoomServiceType
    
    //MARK: Init
    
    init(roomService: EnterRoomServiceType) {
        self.roomService = roomService
    }
    
    //MARK: Properties
    
    @Published var inviteCode: String = ""
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .editInviteCode:
            configButtonisEnabled()
            
        case .enterButtonDidClicked:
            roomService.validateParticipationCode(inviteCode: inviteCode)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        owner.state.isValid = false
                        switch error {
                        case .deletedRoomCode, .invalidateCode, .alreadyMatchedError:
                            owner.state.errMessage = "참여가 불가능한 방이야! 혹시 초대코드에 공백이 있는지 확인해줘."
                        case .alreadyInRoomError:
                            owner.state.errMessage = "이미 참여중인 방이야!"
                        }
                    }
                }, receiveValue: { _ in
                    owner.state.isValid = true
                    owner.state.canPush = true
                })
                .store(in: cancelBag)
        }
    }
}

extension EnterRoomViewModel {
    func configButtonisEnabled() {
        state.isEnabled = !inviteCode.isEmpty
    }
}
