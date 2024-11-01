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
        case exitButtonDidTap(roomID: String)
        case deleteHistoryButtonDidTap(roomID: String)
    }
    
    
    struct State {
        var rooms: [RoomDetail] = []
        var isLoading = false
    }
    
    //MARK: - Dependency
    
    private var roomService: RoomServiceType
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
            
            roomService.getEnteredRooms()
                .receive(on: DispatchQueue.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty() }
                .assign(to: \.state.rooms, on: owner)
                .store(in: cancelBag)
            
        case .myPageButtonDidTap:
            navigationRouter.push(to: .myPage)
            
        case .makeRoomButtonDidTap:
            navigationRouter.push(to: .editRoom(viewType: .createMode))
            
        case .enterRoomButtonDidTap:
            navigationRouter.push(to: .enterRoom)
            
        case let .roomCellDidTap(roomDetail):
            switch roomDetail.state {
            case .notStarted:
                navigationRouter.push(to: .manitoWaitingRoom(roomDetail: roomDetail) )
            case .inProgress:
                navigationRouter.push(to: .matchedRoom(roomInfo: roomDetail))
            case .completed:
                navigationRouter.push(to: .finish(roomDetail: roomDetail))
            case .deleted: return
            }
            
            
        case let .exitButtonDidTap(roomID):
            roomService.exitRoom(with: roomID)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty()}
                .sink {
                    guard let removedIndex = owner.state.rooms.firstIndex(where: { $0.id == roomID })
                    else { return }
                    owner.state.rooms.remove(at: removedIndex)
                }
                .store(in: cancelBag)
                
        case let .deleteHistoryButtonDidTap(roomID):
            roomService.deleteHistoryRoom(with: roomID)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty()}
                .sink {
                    guard let removedIndex = owner.state.rooms.firstIndex(where: { $0.id == roomID })
                    else { return }
                    owner.state.rooms.remove(at: removedIndex)
                }
                .store(in: cancelBag)
        }
    }
}

