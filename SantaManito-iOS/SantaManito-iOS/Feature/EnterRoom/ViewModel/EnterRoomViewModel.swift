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
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            Analytics.shared.track(.inviteCode)
        case .enterButtonDidTap:
            Analytics.shared.track(.inviteCodeEnterBtn)
            roomService.enterRoom(at: inviteCode)
                .receive(on: RunLoop.main)
                .mapError { [weak self] error in
                    self?.state.enterFailMessage = (true, error.description)
                    return error
                }
                .flatMap { [weak self] roomID -> AnyPublisher<RoomDetail, Error> in
                    guard let self else { return Empty().eraseToAnyPublisher() }
                    return self.roomService.getRoomInfo(with: roomID)
                        .catch { _ in Empty() }
                        .eraseToAnyPublisher()
                }
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { [weak self] roomDetail in
                    self?.navigationRouter.push(to: .manitoWaitingRoom(roomDetail: roomDetail))
                }).store(in: cancelBag)
        }
    }
}
