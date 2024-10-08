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
        var enterButtonDisabled: Bool = false
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
        switch action {
        case .enterButtonDidClicked:
            roomService.enterRoom(inviteCode: inviteCode)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.state.enterFailMessage = (true, error.description)
                    }
                }, receiveValue: { [weak self] _ in
                    self?.navigationRouter.push(to: .manitoWaitingRoom(roomDetail: .stub)) // stub교체
                })
                .store(in: cancelBag)
        }
    }
}
