//
//  ManitoRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import Foundation
import Combine

class ManitoWaitingRoomViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
        case refreshButtonDidTap
        case copyInviteCodeDidTap
        case matchingButtonDidTap
        case editButtonDidTap
        case backButtonDidTap
    }
    
    struct State {
        var roomDetail: RoomDetail = .stub1
        var isLoading: Bool = false
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutableType,
        roomDetail: RoomDetail
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.state.roomDetail = roomDetail
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    @MainActor func send(action: Action) {
        switch action {
        case .onAppear:
            Analytics.shared.track(.roomManittoList)
            send(action: .refreshButtonDidTap)
        case .refreshButtonDidTap:
            Analytics.shared.track(.roomRefreshBtn)
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.roomService.getRoomInfo(with: self.state.roomDetail.id) },
                onSuccess: { [weak self] roomDetail in self?.state.roomDetail = roomDetail }
            )
            
        case .copyInviteCodeDidTap:
            Analytics.shared.track(.roomCodeCopyBtn)
            SMPasteBoard.paste(with: state.roomDetail.invitationCode)
            
        case .matchingButtonDidTap:
            Analytics.shared.track(.roomStartBtn)
            navigationRouter.push(to: .matchRoom(roomID: state.roomDetail.id))
            
        case .editButtonDidTap:
            Analytics.shared.track(.roomEditBtn)
            navigationRouter.push(to: .editRoom(viewType: .editMode(roomID: state.roomDetail.id, info: state.roomDetail.toMakeRoomInfo())))
        case .backButtonDidTap:
            navigationRouter.popToRootView()
        }
    }
}
