//
//  MakeRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import Foundation
import Combine

final class EditRoomInfoViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear // 방이름 작성
        case increaseDuedate // 마니또 마감 날짜 늘리기
        case decreaseDuedate // 마니또 마감 날짜 줄이기
        case configDuedateTime(Date) // 마니또 종료 시간 설정
        case noMissionButtonDidTap // 미션없이 방을 생성하려고 할때
        case missionButtonDidTap // 미션 설정 후 방을 생성하려고 할때
        case ignoreMissionButtonDidTap
        case dismissAlert
        case editButtonDidTap // 수정 버튼을 눌렀을 때
    }
    
    struct State {
        var isBottomButtonsDisabled: Bool = false
        var isPresented: Bool = false
        var canIncreaseDays: Bool = true
        var canDecreaseDays: Bool = true
        var dueDate: String = Date().toDueDateAndTime
        var description: String = ""
    }
    
    //MARK: - Dependency
    
    private(set) var viewType: EditRoomViewType
    private var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: - Init
    
    init(
        viewType: EditRoomViewType,
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.viewType = viewType
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.roomInfo = viewType.info
        self.roomID = viewType.roomID
        
        observe()
    }
    
    //MARK: - Properties
    
    private let roomID: String?
    @Published var roomInfo: MakeRoomInfo
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: - Methods
    
    func observe() {
        $roomInfo
            .map { $0.name.isEmpty }
            .assign(to: \.state.isBottomButtonsDisabled, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { $0.totalDurationDays < 14 }
            .assign(to: \.state.canIncreaseDays, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { $0.totalDurationDays > 3 }
            .assign(to: \.state.canDecreaseDays, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { roomInfo in
                let adjustedDate = roomInfo.expirationDate
                return "\(adjustedDate.toDueDate) \(roomInfo.dueDate.toDueDateTime)"
            }
            .assign(to: \.state.dueDate, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { [weak self] roomInfo in
                switch self?.viewType {
                case .createMode:
                    return "언제까지 마니또 게임하게 할거야\n내 마니또를 봐 산타 기다리잖아"
                case .editMode:
                    return "오늘부터 \(roomInfo.remainingDays)일 후인 \(roomInfo.dueDate.toDueDateWithoutYear)\n\(roomInfo.dueDate.toDueDateTime)까지 진행되는 마니또"
                case .none:
                    return  ""
                }
            }
            .assign(to: \.state.description, on: self)
            .store(in: cancelBag)
    }
    
    func send(action: Action) {
        
        switch action {
        case .onAppear:
            return
        case .increaseDuedate:
            if state.canIncreaseDays { roomInfo.totalDurationDays += 1 }
            
        case .decreaseDuedate:
            if state.canDecreaseDays { roomInfo.totalDurationDays -= 1 }
            
        case .configDuedateTime(let dueDateTime):
            roomInfo.dueDate = dueDateTime
            
        case .noMissionButtonDidTap:
            state.isPresented = true
            
        case .missionButtonDidTap:
            navigationRouter.push(to: .makeMission(roomInfo: roomInfo))
            
        case .ignoreMissionButtonDidTap:
            state.isPresented = false
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: []))
                    
        case .dismissAlert:
            state.isPresented = false
            navigationRouter.push(to: .makeMission(roomInfo: roomInfo))
            
        case .editButtonDidTap:
            guard let roomID = viewType.roomID else { return }
            roomService.editRoomInfo(with: roomID, info: roomInfo)
                .catch { _ in Empty() }
                .sink { [weak self] _ in
                    self?.navigationRouter.pop()
                    print("성공해서 화면 전환")
                }
                .store(in: cancelBag)
        }
    }
}
