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
        case enterButtonDidTap
    }
    struct State {
        var enterButtonDisabled: Bool = false
        var enterFailMessage: (isPresented: Bool, text: String) = (false, "")
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType // 임시의
    private var editRoomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        editRoomService: EditRoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.roomService = roomService
        self.editRoomService = editRoomService
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
            editRoomService.enterRoom(inviteCode: inviteCode)
                .mapError { [weak self] error in
                    self?.state.enterFailMessage = (true, error.description)
                    return error
                }
                .flatMap { [weak self] roomID -> AnyPublisher<RoomDetail, Error> in
                    guard let self else { return Empty().eraseToAnyPublisher() }
                    return self.roomService.fetch(with: roomID)
                        .catch { _ in Empty() }
                        .eraseToAnyPublisher()
                }
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { [weak self] roomDetail in
                    self?.navigationRouter.push(to: .manitoWaitingRoom(roomDetail: roomDetail))
                }).store(in: cancelBag)
        }
    }
}
