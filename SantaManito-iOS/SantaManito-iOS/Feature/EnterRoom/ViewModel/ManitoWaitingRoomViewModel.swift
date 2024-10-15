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
        case matchingButtonDidTap //매칭하는 화면으로 넘어가서 서버통신하는게 맞겠지?
        case editButtonDidTap // 방 수정하기 뷰로 넘어감
    }
    
    struct State {
        var roomDetail: RoomDetail = .stub1 //TODO: Stub 교체
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
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            return
            
        case .refreshButtonDidTap:
            roomService.getRoomInfo(with: state.roomDetail.id)
                .receive(on: DispatchQueue.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty() }
                .assign(to: \.state.roomDetail, on: owner)
                .store(in: cancelBag)
            
        case .copyInviteCodeDidTap:
            SMPasteBoard.paste(with: state.roomDetail.invitationCode)
            
        case .matchingButtonDidTap:
//            navigationRouter.push(to: .matchRoom) -> 원래는 이거
            navigationRouter.push(to: .matchedRoom(roomInfo: state.roomDetail))
            
        case .editButtonDidTap:
            navigationRouter.push(to: .editRoom(viewType: .editMode(roomID: state.roomDetail.id, info: state.roomDetail.toMakeRoomInfo())))
        }
    }
}
