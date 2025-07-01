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
        case exitButtonDidTap(roomDetail: RoomDetail) // 확인용 이벤트
        case creatorExitButtonDidTap(roomDetail: RoomDetail) // 실제 나가기
        case guestExitButtonDidTap(roomDetail: RoomDetail) // 실제 나가기
        case dismissAlert
        case deleteHistoryButtonDidTap(roomID: String)
        
    }
    
    
    struct State {
        var rooms: [RoomDetail] = []
        var creatorExitAlert = (isPresented: false, detail: RoomDetail.stub1)
        var guestExitAlert = (isPresented: false, detail: RoomDetail.stub1)
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
    
    @MainActor func send(_ action: Action) {
        
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            Analytics.shared.track(.home)
            send(.refreshButtonDidTap)
        case .refreshButtonDidTap:
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.roomService.getEnteredRooms() },
                onSuccess: { [weak self] rooms in
                    self?.state.rooms = rooms
                }
            )
            
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
            case .expired: return
            case .deleted: return
           
            }
            
        case .dismissAlert:
            Analytics.shared.track(.leaderExitPopupStayBtn)
            state.creatorExitAlert.isPresented = false
            state.guestExitAlert.isPresented = false
            
        case let .exitButtonDidTap(roomDetail):
            if roomDetail.isHost {
                Analytics.shared.track(.leaderExitPopup)
                state.creatorExitAlert = (true,roomDetail)
            } else {
                state.guestExitAlert = (true, roomDetail)
            }
        case let .creatorExitButtonDidTap(roomDetail):
            Analytics.shared.track(.leaderExitPopupExitBtn)
            
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.roomService.deleteRoom(with: roomDetail.id) },
                onSuccess: { [weak self] _ in
                    guard let removedIndex = owner.state.rooms.firstIndex(where: { $0.id == roomDetail.id })
                    else { return }
                    self?.state.rooms.remove(at: removedIndex)
                }
            )
            
        case let .guestExitButtonDidTap(roomDetail):
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.roomService.exitRoom(with: roomDetail.id) },
                onSuccess: { [weak self] _ in
                    guard let removedIndex = owner.state.rooms.firstIndex(where: { $0.id == roomDetail.id })
                    else { return }
                    self?.state.rooms.remove(at: removedIndex)
                }
            )

        case let .deleteHistoryButtonDidTap(roomID):
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.roomService.deleteHistoryRoom(with: roomID) },
                onSuccess: { [weak self] _ in
                    guard let removedIndex = owner.state.rooms.firstIndex(where: { $0.id == roomID })
                    else { return }
                    self?.state.rooms.remove(at: removedIndex)
                }
            )
        }
    }
}

