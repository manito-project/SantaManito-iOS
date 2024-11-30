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
        case deleteRoomButtonDidTap // 휴지통 버튼 눌럿을때?
        case goHomeButtonDidTap
        case toggleViewTypeButtonDidTap
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
            
        var member: Member {
            guard let 내가마니또인멤버Index = roomInfo.members.firstIndex(where: { $0.manitto?.id == UserDefaultsService.shared.userID})
            else { return .init(santa: .stub1) }
            return roomInfo.members[내가마니또인멤버Index]
        }
        
        var mission: String {
            let missionId = member.santa.missionId
            guard let mission = roomInfo.mission.first(where: {$0.id == missionId}) else {
                return "이번에는 미션 없이 마니또만 매칭됐어!"
            }
            return mission.content
        }
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
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            return

        case .toggleViewTypeButtonDidTap:
            state.viewType = state.viewType == .me ? .all : .me
            
        case .deleteRoomButtonDidTap:
            roomService.exitRoom(with: state.roomInfo.id)
                .catch { _ in Empty() }
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.popToRootView()
                })
                .store(in: cancelBag)
            
        case .goHomeButtonDidTap:
            self.navigationRouter.popToRootView()
        }
    }
}
