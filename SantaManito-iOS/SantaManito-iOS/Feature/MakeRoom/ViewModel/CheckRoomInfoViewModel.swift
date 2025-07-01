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
        var isLoading: Bool = false
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
    
    @MainActor func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .deleteMission(let mission):
            Analytics.shared.track(.makeCompleteMissionMinusBtn)
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .makeRoomButtonDidTap:
            Analytics.shared.track(.makeCompleteBtn)
            let request = CreateRoomRequest(roomInfo, missionList) // TODO: 미션 로직 수정
            
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.roomService.createRoom(roomRequest: request) },
                onSuccess: { [weak self] inviteCode in
                    self?.inviteCode = inviteCode
                    self?.state.isPresented = true
                    Analytics.shared.track(.makeCodeComplePopup)
                }
            )

            
        case .copyInviteCode:
            Analytics.shared.track(.makeCodeCopyBtn)
            UIPasteboard.general.string = inviteCode
            state.isPresented = false
            navigationRounter.popToRootView()
        }
    }
}
