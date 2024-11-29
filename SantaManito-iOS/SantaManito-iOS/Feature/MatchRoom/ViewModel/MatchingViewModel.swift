//
//  MatchingViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import Foundation
import Combine

import Foundation
import Combine

class MatchingViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
    }
    
    struct State {
        var isAnimating: Bool = false
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutable
    private let roomID: String
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutable,
        roomID: String
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.roomID = roomID
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            Just(roomID)
                .flatMap(roomService.matchRoom)
                .map { owner.roomID }
                .flatMap(roomService.getRoomInfo)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isAnimating, on: owner)
                .catch { [weak self]_  in
                    self?.navigationRouter.popToRootView()
                    return Empty<RoomDetail, Never>()
                }
                .sink { roomDetail in
                    owner.navigationRouter.push(to: .matchedRoom(roomInfo: roomDetail))
                }
                .store(in: cancelBag)
        }
    }
}
