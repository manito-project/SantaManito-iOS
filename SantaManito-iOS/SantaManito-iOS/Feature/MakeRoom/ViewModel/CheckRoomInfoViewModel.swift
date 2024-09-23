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
        observe()
    }
    
    //MARK: - Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    @Published var inviteCode: String?
    
    //MARK: - Methods
    
    func observe() {
        $roomInfo
            .map { roomInfo in
                let adjustDay = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: roomInfo.dueDate))!
                print(adjustDay)
                return adjustDay.toDueDateAndTime
            }
            .assign(to: \.state.dueDate, on: self)
            .store(in: cancelBag)
    }
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .makeRoomButtonClicked:
            roomService.createRoom(roomInfo: roomInfo, missions: missionList)
                .catch { _ in Empty() }
                .sink { inviteCode in
                    owner.inviteCode = inviteCode
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
