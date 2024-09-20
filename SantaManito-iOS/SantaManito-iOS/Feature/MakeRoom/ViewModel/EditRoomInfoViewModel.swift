//
//  MakeRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import Foundation
import Combine

//TODO: 서버통신 되기 전에 description 어떻게 설정할지 고민
enum ViewType {
    case createMode
    case editMode(Int, Date)
    
    var title: String {
        switch self {
        case .createMode:
            return "방 정보 설정"
        case .editMode:
            return "방 정보 수정"
        }
    }
    
    var description: String {
        switch self {
        case .createMode:
            return "언제까지 마니또 게임하게 할거야\n내 마니또를 봐 산타 기다리잖아"
        case .editMode(let remainingDays, let dueDate):
            return "오늘부터 \(remainingDays)일 후인 \(dueDate.toDueDateWithoutYear)\n\(dueDate.toDueDateTime)까지 진행되는 마니또"
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
    }
    
    
    //MARK: - Dependency
    
    var viewType: ViewType
    var roomService: EditRoomServiceType
    
    //MARK: - Init
    
    init(viewType: ViewType, roomService: EditRoomServiceType) {
        self.viewType = viewType
        self.roomService = roomService
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
                        owner.configDuedata()
                    }
                    .store(in: cancelBag)
            }
            checkRemainingDaysInRange()
            configDuedata()
            
        case .configRoomName(let name):
            roomInfo.name = name.count >= 17 ? String(name.prefix(17)) : name
            updateButtonState()
            
        case .increaseDuedate:
            if state.canIncreaseDays {
                adjustRemainingDays(by: 1)
            }
            
        case .decreaseDuedate:
            if state.canDecreaseDays {
                adjustRemainingDays(by: -1)
            }
            
        case .configDuedateTime(let dueDateTime):
            roomInfo.dueDate = dueDateTime
            configDuedata()
            
        case .noMissionButtonClicked:
            print("noMissionButtonClicked")
            state.isPresented = true
            //미션 미설정 확인 모달 보여주고 거기서도 okay하면 바로 방 확정짓는 파일로 넘어가기
            
        case .missionButtonClicked:
            //미션 만드는 화면으로 넘어가
            print("missionButtonClicked")
            
        case .ignoreMissionButtonClicked:
            print("방 정보 확인 뷰로 넘어가기")
            break
            
        case .dismissAlert:
            //미션 만드는 화면으로 넘어가
            state.isPresented = false
            
        case .editButtonClicked:
            roomService.editRoomInfo(with: "1", roomInfo: roomInfo)
                .catch { _ in Empty() }
                .sink { _ in
                    //화면 전환
                    print("성공해서 화면 전환")
                }
                .store(in: cancelBag)
        }
    }
}

extension EditRoomInfoViewModel {
    func adjustRemainingDays(by offset: Int) {
        roomInfo.remainingDays += offset
        checkRemainingDaysInRange()
        configDuedata()
    }
    
    /// 남은 기한을 3~14일 사이로 설정가능한지 확인하는 함수
    func checkRemainingDaysInRange() {
        state.canIncreaseDays = roomInfo.remainingDays >= 14 ? false: true
        state.canDecreaseDays = roomInfo.remainingDays <= 3 ? false: true
    }
    
    ///마니또 공개일을 계산하는 함수
    func configDuedata() {
        let addingDate = Date().addingDays(remainingDays: roomInfo.remainingDays)
        state.dueDate = addingDate.toDueDate + " " + roomInfo.dueDate.toDueDateTime
    }
    
    func updateButtonState() {
        state.isEnabled = !roomInfo.name.isEmpty
    }
}
