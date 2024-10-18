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
        fileprivate var roomInfo: RoomDetail = .stub1
        
        var roomName: String { roomInfo.name }
        var description: String {
            if roomInfo.remainingDays > 0 {
                "오늘부터 \(roomInfo.remainingDays)일 후인 \(roomInfo.expirationDate.toDueDateWithoutYear)\n\(roomInfo.expirationDate.toDueDateTime)까지 진행되는 마니또"
            } else {
                "\(roomInfo.expirationDate.toDueDateTime)까지 진행되는 마니또"
            }
        }
        fileprivate var member: Member {
            guard let 내가마니또인멤버Index = roomInfo.members.firstIndex(where: { $0.manitto?.id == UserDefaultsService.shared.userID})
            else { return .init(santa: .stub1) }
            return roomInfo.members[내가마니또인멤버Index]
        }
        
        var me: User {
            member.santa
        }
        var mannito: User {
            member.manitto ?? .stub1
        }
        
        var mission: String {
            roomInfo.mission.first?.content ?? "" //TODO: 내 미션 찾는 로직 필요
        }
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutable
    
    private let roomDetail: RoomDetail
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutable,
        roomInfo: RoomDetail
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.roomDetail = roomInfo
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            return

        case .goHomeButtonDidTap:
            navigationRouter.popToRootView()
        }
    }
}
