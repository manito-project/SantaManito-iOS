//
//  MatchingResultViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import Foundation
import Combine

class MatchingResultViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
        case goHomeButtonDidTap
    }
    
    struct State {
        var manito: MatchingFinishData =
            .init(
                userID: 1,
                santaUserID: 2,
                manittoUserID: 1,
                myMission: MissionToMe(content: "뭐시기뭐시기뭐시기뭐시기"),
                missionToMe: MissionToMe(content: "뭐시기뭐시기뭐시기뭐시기"),
                santaUsername: "류희재",
                manittoUsername: "장석우"
            )
        var room: RoomDetail = .stub1 //TODO: Stub 교체
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var matchRoomService: MatchRoomServiceType
    private var editRoomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutable
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        matchRoomService: MatchRoomServiceType,
        editRoomService: EditRoomServiceType,
        navigationRouter: NavigationRoutable
    ) {
        self.roomService = roomService
        self.matchRoomService = matchRoomService
        self.editRoomService = editRoomService
        self.navigationRouter = navigationRouter
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            matchRoomService.getManito("")
                .catch { _ in Empty() }
                .assign(to: \.state.manito, on: self)
                .store(in: cancelBag)
                
            roomService.fetch(with: "roomID")
                .catch { _ in Empty() }
                .assign(to: \.state.room, on: self)
                .store(in: cancelBag)

        case .goHomeButtonDidTap:
            navigationRouter.popToRootView()
        }
    }
}
