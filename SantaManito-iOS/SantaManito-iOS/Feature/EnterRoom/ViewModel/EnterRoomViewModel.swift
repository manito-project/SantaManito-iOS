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
        case onAppear
        case enterButtonDidTap
    }
    struct State {
        var enterButtonDisabled: Bool = false
        var enterFailMessage: (isPresented: Bool, text: String) = (false, "")
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType 
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
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
    
    @MainActor
    func send(action: Action) {
        switch action {
        case .onAppear:
            Analytics.shared.track(.inviteCode)
        case .enterButtonDidTap:
            Analytics.shared.track(.inviteCodeEnterBtn)
            performTask(
                operation: { try await self.roomService.enterRoom(at: self.inviteCode) },
                onSuccess: { [weak self] roomID in
                    self?.getRoomInfo(roomID)
                }, onError: { [weak self] error in
                    let enterError = error as! EnterError
                    self?.state.enterFailMessage = (true, enterError.description)
                }
            )
        }
    }
}

extension EnterRoomViewModel {
    @MainActor
    func getRoomInfo(_ roomID: String) {
        performTask(
            operation: { try await self.roomService.getRoomInfo(with: roomID) },
            onSuccess: { [weak self] roomDetail in
                self?.navigationRouter.push(to: .manitoWaitingRoom(roomDetail: roomDetail))
            }
        )
    }
}
