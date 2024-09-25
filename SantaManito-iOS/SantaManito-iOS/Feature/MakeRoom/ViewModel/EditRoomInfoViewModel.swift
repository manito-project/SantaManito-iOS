//
//  MakeRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import Foundation
import Combine

//TODO: 서버통신 되기 전에 description 어떻게 설정할지 고민
enum EditRoomViewType: Hashable {
    case createMode
    case editMode
    
    var title: String {
        switch self {
        case .createMode:
            return "방 정보 설정"
        case .editMode:
            return "방 정보 수정"
        }
    }
}

final class EditRoomInfoViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear // 방이름 작성
        case configRoomName(String) // 방이름 작성
        case increaseDuedate // 마니또 마감 날짜 늘리기
        case decreaseDuedate // 마니또 마감 날짜 줄이기
        case configDuedateTime(Date) // 마니또 종료 시간 설정
        case noMissionButtonClicked // 미션없이 방을 생성하려고 할때
        case missionButtonClicked // 미션 설정 후 방을 생성하려고 할때
        case ignoreMissionButtonClicked
        case dismissAlert
        case editButtonClicked // 수정 버튼을 눌렀을 때
    }
    
    struct State {
        var isEnabled: Bool = false
        var isPresented: Bool = false
        var canIncreaseDays: Bool = true
        var canDecreaseDays: Bool = true
        var dueDate: String = Date().toDueDateAndTime
        var description: String = ""
    }
    
    //MARK: - Dependency
    
    var viewType: EditRoomViewType
    private var roomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: - Init
    
    init(
        viewType: EditRoomViewType,
        roomService: EditRoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.viewType = viewType
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    //MARK: - Properties
    
    @Published var roomInfo: MakeRoomInfo = MakeRoomInfo(
        name: "",
        remainingDays: 3,
        dueDate: Date()
    )
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: - Methods
    
    func observe() {
        $roomInfo
            .map { !$0.name.isEmpty }
            .assign(to: \.state.isEnabled, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { $0.remainingDays < 14 }
            .assign(to: \.state.canIncreaseDays, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { $0.remainingDays > 3 }
            .assign(to: \.state.canDecreaseDays, on: self)
            .store(in: cancelBag)
        
        $roomInfo
            .map { roomInfo in
                let adjustedDate = roomInfo.dueDate.addingDays(remainingDays: roomInfo.remainingDays)
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
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            if case .editMode = viewType {
                roomService.getRoomInfo(with: "1")
                    .catch { _ in Empty() }
                    .sink { roomInfo in
                        owner.roomInfo = roomInfo
                    }
                    .store(in: cancelBag)
            }
            
        case .configRoomName(let name):
            roomInfo.name = name.count >= 17 ? String(name.prefix(17)) : name
            
        case .increaseDuedate:
            if state.canIncreaseDays { roomInfo.remainingDays += 1 }
            
        case .decreaseDuedate:
            if state.canDecreaseDays { roomInfo.remainingDays -= 1 }
            
        case .configDuedateTime(let dueDateTime):
            roomInfo.dueDate = dueDateTime
            
        case .noMissionButtonClicked:
            state.isPresented = true
            
        case .missionButtonClicked:
            navigationRouter.push(to: .makeMission(roomInfo: roomInfo))
            
        case .ignoreMissionButtonClicked:
            state.isPresented = false
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: []))
                    
        case .dismissAlert:
            state.isPresented = false
            navigationRouter.push(to: .makeMission(roomInfo: roomInfo))
            
        case .editButtonClicked:
            roomService.editRoomInfo(with: "1", roomInfo: roomInfo)
                .catch { _ in Empty() }
                .sink { [weak self] _ in
                    self?.navigationRouter.pop()
                    print("성공해서 화면 전환")
                }
                .store(in: cancelBag)
        }
    }
}
