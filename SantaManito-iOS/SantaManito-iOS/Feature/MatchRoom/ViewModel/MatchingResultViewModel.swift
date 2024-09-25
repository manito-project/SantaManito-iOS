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
        case goHomeButtonClicked
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
        var room: MakeRoomInfo = MakeRoomInfo(name: "마니또 방", remainingDays: 3, dueDate: Date()) //TODO: 나중에 서버통신으로 변경해야됨
    }
    
    //MARK: Dependency
    
    private var matchRoomService: MatchRoomServiceType
    private var editRoomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutable
    
    //MARK: Init
    
    init(
        matchRoomService: MatchRoomServiceType,
        editRoomService: EditRoomServiceType,
        navigationRouter: NavigationRoutable
    ) {
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
                
            editRoomService.getRoomInfo(with: "")
                .catch { _ in Empty() }
                .assign(to: \.state.room, on: self)
                .store(in: cancelBag)

        case .goHomeButtonClicked:
            navigationRouter.popToRootView()
        }
    }
}
