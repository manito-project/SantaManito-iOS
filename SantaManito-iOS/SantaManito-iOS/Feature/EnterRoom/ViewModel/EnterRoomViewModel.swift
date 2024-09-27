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
        case enterButtonDidClicked
    }
    struct State {
        var enterButtonDisabled: Bool = false //MARK: 히디의 고민: isEnabled라는 변수명이 너무 모호함 (초대코드에 텍스트가 있으면 버튼을 누를 수 있도록 하는 역할)
        var enterFailMessage: (isPresented: Bool, text: String) = (false, "")
    }
    
    //MARK: Dependency
    
    private var roomService: EnterRoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: EnterRoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    //MARK: Properties
    
    @Published var inviteCode: String = ""
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func observe() {
        $inviteCode
            .map { !$0.isEmpty }
            .assign(to: \.state.enterButtonDisabled, on: self)
            .store(in: cancelBag)
    }
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .enterButtonDidClicked:
            roomService.validateParticipationCode(inviteCode: inviteCode)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        switch error {
                        case .deletedRoomCode, .invalidateCode, .alreadyMatchedError:
                            owner.state.enterFailMessage = (true, "참여가 불가능한 방이야! 혹시 초대코드에 공백이 있는지 확인해줘.")
                        case .alreadyInRoomError:
                            owner.state.enterFailMessage = (true, "참여가 불가능한 방이야! 혹시 초대코드에 공백이 있는지 확인해줘.")
                        }
                    }
                }, receiveValue: { _ in
                    owner.navigationRouter.push(to: .manitoWaitingRoom)
                })
                .store(in: cancelBag)
        }
    }
}
