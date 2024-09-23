//
//  HomeViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//

import Combine

class HomeViewModel: ObservableObject {
    
//MARK: - Action, State
    
    enum Action {
        case onAppear
        case refreshButtonDidTap
        case myPageButtonDidTap
        case makeRoomButtonDidTap
        case joinRoomButtonDidTap
        case roomCellDidTap
    }
    
    
    struct State {
        
        var desination: Destination = .none
        var rooms: [RoomInfo] = []
        
        enum Destination {
            case none
            case myPage
            case makeRoom
            case joinRoom
            case room
        }
    }
    
    //MARK: - Dependency
    
    var roomService: RoomServiceType
    
    //MARK: - Properties
    
    @Published var state = State()
    private let cancelBag = CancelBag()

    //MARK: - Init
    
    init(roomService: RoomServiceType) {
        self.roomService = roomService
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        
        weak var owner = self
        guard let owner else { return }
        
        switch action {
            
        case .onAppear:
            roomService.fetch()
                .catch { _ in Empty() }
                .assign(to: \.state.rooms, on: owner)
                .store(in: cancelBag)
            
        case .myPageButtonDidTap:
            break
        
        case .makeRoomButtonDidTap:
            break
            
        case .joinRoomButtonDidTap:
            break
        case .refreshButtonDidTap:
            break
        case .roomCellDidTap:
            break
        }
    }
}
    
