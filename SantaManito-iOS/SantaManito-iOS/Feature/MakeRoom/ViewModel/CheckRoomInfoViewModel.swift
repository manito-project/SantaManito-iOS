//
//  CheckIRoomInfoViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import UIKit
import Combine

class CheckRoomInfoViewModel: ObservableObject {
    
    //MARK: - Action, State
    
    enum Action {
        case onAppear
        case makeRoomButtonClicked
        case deleteMission(Mission)
        case copyInviteCode
    }
    
    struct State {
        var isPresented: Bool = false
        var dueDate: String = Date().toDueDateAndTime
    }
    
    //MARK: - Dependency
    
    var roomService: EditRoomServiceType
    @Published var roomInfo: MakeRoomInfo = MakeRoomInfo(
        name: "",
        remainingDays: 3,
        dueDate: Date()
    )
    @Published var missionList: [Mission]
    
    //MARK: - Init
    
    init(roomInfo: MakeRoomInfo,
         missionList: [Mission],
         roomService: EditRoomServiceType
    ) {
        self.roomInfo = roomInfo
        self.missionList = missionList
        self.roomService = roomService
    }
    
    //MARK: - Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    @Published var inviteCode: String?
    
    //MARK: - Methods
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            updateDueDate() // 서버통신 이후 날짜로 변환하는 코드
            
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .makeRoomButtonClicked:
            roomService.createRoom(roomInfo: roomInfo, missions: missionList)
                .catch { _ in Empty() }
                .sink { inviteCode in
                    owner.inviteCode = inviteCode
                    owner.updateDueDate()
                    owner.state.isPresented = true
                }
                .store(in: cancelBag)
            
        case .copyInviteCode:
            print("초대코드 복사")
            UIPasteboard.general.string = inviteCode
            state.isPresented = false
            break
        }
    }
}

extension CheckRoomInfoViewModel {
    ///마니또 공개일을 계산하는 함수
    func updateDueDate() {
        // 날짜와 관련된 내용
        guard let futureDate = Calendar.current.date(byAdding: .day, value: roomInfo.remainingDays, to: Date()),
              let newDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: futureDate)) else { return }
        //시간과 관련된 내용
        state.dueDate = newDate.toDueDate + " " + roomInfo.dueDate.toDueDateTime
    }
}
