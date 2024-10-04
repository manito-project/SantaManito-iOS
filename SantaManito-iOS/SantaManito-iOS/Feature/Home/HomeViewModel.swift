//
//  HomeViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    //MARK: - Action, State
    
    enum Action {
        case onAppear
        case refreshButtonDidTap
        case myPageButtonDidTap
        case makeRoomButtonDidTap
        case enterRoomButtonDidTap
        case roomCellDidTap(roomDetail: RoomDetail)
    }
    
    
    struct State {
        var rooms: [RoomDetail] = []
        var isLoading = false
    }
    
    //MARK: - Dependency
    
    var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    
    //MARK: - Properties
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: - Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        
        weak var owner = self
        guard let owner else { return }
        
        switch action {
            
        case .onAppear, .refreshButtonDidTap:
            state.isLoading = true
            roomService.fetchAll()
                .receive(on: DispatchQueue.main)
                .catch { _ in Empty() }
                .handleEvents(receiveOutput: { _ in owner.state.isLoading = false })
                .assign(to: \.state.rooms, on: owner)
                .store(in: cancelBag)
            
        case .myPageButtonDidTap:
            navigationRouter.push(to: .myPage)
            
        case .makeRoomButtonDidTap:
            navigationRouter.push(to: .editRoom(viewType: .createMode))
            
        case .enterRoomButtonDidTap:
            navigationRouter.push(to: .enterRoom)
            
        case let .roomCellDidTap(roomDetail):
            navigationRouter.push(to: .manitoWaitingRoom(roomDetail: roomDetail) )
        }
    }
}

