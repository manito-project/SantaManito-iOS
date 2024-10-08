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
        var viewType: FinishViewType = .all
        var me: String = "류희재"
        var manito: MatchingFinishData = .init(
            userID: 1, 
            santaUserID: 2,
            manittoUserID: 3,
            myMission: MissionToMe(content: ""), 
            missionToMe: MissionToMe(content: ""),
            santaUsername: "", 
            manittoUsername: ""
        )
        var roomName: String = ""
        var description: String = ""
        var participateList: [MatchingFinishData] = []
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var matchRoomService: MatchRoomServiceType
    private var editRoomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        matchRoomService: MatchRoomServiceType,
        editRoomService: EditRoomServiceType,
        navigationRouter: NavigationRoutableType
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
                .map { [weak self] roomInfo in
                    self?.state.roomName = roomInfo.name
                    let startDate = roomInfo.expirationDate.adjustDays(remainingDays: -Int(roomInfo.remainingDays)!).toDueDate
                    let endDate = roomInfo.expirationDateToString
                    return "\(startDate) ~ \(endDate)\n\(roomInfo.remainingDays)일간의 산타마니또 끝!"
                }
                .catch { _ in Empty() }
                .assign(to: \.state.description, on: self)
                .store(in: cancelBag)
        case .toggleViewTypeButtonDidTap:
            state.viewType = state.viewType == .me ? .all : .me
            
        case .deleteRoomButtonDidTap:
            editRoomService.deleteRoom(with: "roomID")
                .catch { _ in Empty() }
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.popToRootView()
                })
                .store(in: cancelBag)
            
        case .goHomeButtonDidTap:
            self.navigationRouter.popToRootView()
        }
    }
}
