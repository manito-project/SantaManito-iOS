//
//  FinishViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/23/24.
//

import Foundation

import Foundation
import Combine

enum FinishViewType {
    case me
    case all
    
    var buttonText: String {
        switch self {
        case .me:
            return "전체 결과 보기"
        case .all:
            return "내 결과 보기"
        }
    }
}

class FinishViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
        case deleteRoomButtonDidTap
        case toggleViewTypeButtonDidTap
        case alert(AlertAction)
    }
    
    enum AlertAction {
        case exitRoom
        case cancel
    }
    
    struct State {
        
        var viewType: FinishViewType = .me
        
        fileprivate var roomInfo: RoomDetail = .stub1
        
        var roomName: String {
            roomInfo.name
        }
        
        var description: String {
            roomInfo.createdAt.toDueDate + " - " +
            roomInfo.expirationDate.toDueDate + "\n" +
            String(roomInfo.totalDurationDays) + "일간의 산타 마니또 끝"
        }
        
        var members: [Member] { roomInfo.members }
        
        var mySanta: Member {
            roomInfo.members.filter { $0.manitto?.id == UserDefaultsService.shared.userID }.first
            ?? .init(santa: .stub1)
        }
        
        var mySantaMission: String {
            roomInfo.mission.filter { $0.id == mySanta.santa.missionId }.first?.content ?? "이번에는 미션 없이 마니또만 매칭됐어!"
        }
        
        var exitRoomAlertIsPresented = false
    }
    
    //MARK: Dependency
    
    private let roomService: RoomServiceType
    private let navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutableType,
        roomInfo: RoomDetail
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.state.roomInfo = roomInfo
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    @MainActor func send(action: Action) {
        switch action {
        case .onAppear:
            return
            
        case .toggleViewTypeButtonDidTap:
            if state.viewType == .me {
                Analytics.shared.track(.manittoResultViewAllBtn)
                state.viewType = .all
                Analytics.shared.track(.manittoResultAll)
            } else {
                Analytics.shared.track(.manittoResultAllViewMyBtn)
                state.viewType = .me
                Analytics.shared.track(.manittoResultMy)
            }
            
        case .deleteRoomButtonDidTap:
            Analytics.shared.track(.participantExitPopup)
            state.exitRoomAlertIsPresented = true
            
        case .alert(.exitRoom):
            Analytics.shared.track(.participantExitPopupExitBtn)
            state.exitRoomAlertIsPresented = false
            
            performTask(
                operation: { try await self.roomService.deleteHistoryRoom(with: self.state.roomInfo.id) },
                onSuccess: { [weak self] _ in self?.navigationRouter.popToRootView()}
            )
            
        case .alert(.cancel):
            Analytics.shared.track(.participantExitPopupStayBtn)
            state.exitRoomAlertIsPresented = false
        }
    }
}
