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
        fileprivate var roomInfo: RoomDetail
        
        var roomName: String { roomInfo.name }
        var description: String {
            if roomInfo.remainingDays > 0 {
                "오늘부터 \(roomInfo.remainingDays)일 후인 \(roomInfo.expirationDate.toDueDateWithoutYear)\n\(roomInfo.expirationDate.toDueDateTime)까지 진행되는 마니또"
            } else {
                "\(roomInfo.expirationDate.toDueDateTime)까지 진행되는 마니또"
            }
        }
        
        var isAnimating: Bool = false
        var me: SantaUser { roomInfo.me.santa }
        var mannito: User { roomInfo.me.manitto ?? .stub1 }
        var mission: String { roomInfo.myMission?.content ?? "이번에는 미션 없이 마니또만 매칭됐어!" }
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutable
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutable,
        roomInfo: RoomDetail
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.state = State(roomInfo: roomInfo)
    }
    
    //MARK: Properties
    
    @Published private(set) var state: State
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            return 
//            Just(state.roomInfo.id)
//                .flatMap(roomService.getMyInfo)
//                .assignLoading(to: \.state.isAnimating, on: owner)
//                .catch { _ in Empty() }
//                .assign(to: \.state.matchedInfo, on: owner)
//                .store(in: cancelBag)

        case .goHomeButtonDidTap:
            navigationRouter.popToRootView()
        }
    }
}
