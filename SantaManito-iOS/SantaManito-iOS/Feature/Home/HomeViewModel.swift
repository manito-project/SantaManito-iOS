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
        case roomCellDidTap(roomInfo: MakeRoomInfo, misson: [Mission])
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
            roomService.fetch()
                .receive(on: DispatchQueue.main)
                .flatMap { roomInfos -> AnyPublisher<[RoomDetail], Error> in
                    // Step 2: 각 RoomInfo에서 roomID를 가져와 fetch(with:) 호출
                    let roomDetailsPublishers = roomInfos.map { roomInfo in
                        self.roomService.fetch(with: roomInfo.id) // fetch(with:) 결과를 가져옴
                    }
                    
                    // Step 3: 결과들을 배열로 묶어서 반환 (Publishers.MergeMany 사용)
                    return Publishers.MergeMany(roomDetailsPublishers) // 여러 Publisher를 하나로 합침
                        .collect() // RoomDetail을 하나의 배열로 묶음
                        .eraseToAnyPublisher() // AnyPublisher로 반환
                }
                .catch { _ in Empty() }
                .handleEvents(receiveOutput: { [weak self] _ in self?.state.isLoading = false })
                .assign(to: \.state.rooms, on: self)
                .store(in: cancelBag)
            
        case .myPageButtonDidTap:
            navigationRouter.push(to: .myPage)
            
        case .makeRoomButtonDidTap:
            navigationRouter.push(to: .editRoom(viewType: .createMode))
            
        case .enterRoomButtonDidTap:
            navigationRouter.push(to: .enterRoom)
            
        case let .roomCellDidTap(roomInfo, missions):
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: missions) )
        }
    }
}

