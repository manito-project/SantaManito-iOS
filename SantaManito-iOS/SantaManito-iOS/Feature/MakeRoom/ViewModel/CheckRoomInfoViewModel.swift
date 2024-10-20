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
        case makeRoomButtonDidTap
        case deleteMission(Mission)
        case copyInviteCode
    }
    
    struct State {
        var isPresented: Bool = false
    }
    
    //MARK: - Dependency
    
    private var roomService: RoomServiceType
    private var navigationRounter: NavigationRoutableType
    
    @Published var roomInfo: MakeRoomInfo
    @Published var missionList: [Mission]
    
    //MARK: - Init
    
    init(roomInfo: MakeRoomInfo,
         missionList: [Mission],
         roomService: RoomServiceType,
         navigationRouter: NavigationRoutableType
    ) {
        self.roomInfo = roomInfo
        self.missionList = missionList
        self.roomService = roomService
        self.navigationRounter = navigationRouter
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
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .makeRoomButtonDidTap:
            let request = CreateRoomRequest(roomInfo, missionList) // TODO: 미션 로직 수정
            roomService.createRoom(request: request)
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
            navigationRounter.popToRootView()
        }
    }
}
