//
//  MakeMissionViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation
import Combine

class EditMissionViewModel: ObservableObject {
    
    //MARK: - Action, State
    
    enum Action {
        case addMission
        case deleteMission(Mission)
        case skipMissionButtonDidTap
        case makeMissionButtonDidTap
        case ignoreMissionButtonDidTap
        case backButtonDidTap
        case dismissAlert
    }
    
    struct State {
        var isDismiss: Bool = false
        var isEnabled: Bool = false
        var isPresented: Bool = false
        var canDelete: Bool = false
    }
    
    //MARK: - Init
    
    private var navigationRouter: NavigationRoutableType
    private var roomInfo: MakeRoomInfo
    
    init(roomInfo: MakeRoomInfo, navigationRouter: NavigationRoutableType) {
        self.roomInfo = roomInfo
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    //MARK: - Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    @Published var missionList: [Mission] = [Mission(content: "")]
    
    //MARK: - Methods
    
    func observe() {
        $missionList
            .map { $0.allSatisfy { !$0.content.isEmpty } }
            .assign(to: \.state.isEnabled, on: self)
            .store(in: cancelBag)
        
        $missionList
            .map { $0.count > 1 }
            .assign(to: \.state.canDelete, on: self)
            .store(in: cancelBag)
    }
    
    func send(action: Action) {
        switch action {
        case .addMission:
            AnalyticsTaxonomy.makeMissionPlusBtn
            missionList.append(Mission(content: ""))
            
        case .deleteMission(let mission):
            AnalyticsTaxonomy.makeMissionMinusBtn
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .skipMissionButtonDidTap:
            AnalyticsTaxonomy.makeMissionSkipBtn
            state.isPresented = true
            AnalyticsTaxonomy.missionSkipPopup
            
        case .ignoreMissionButtonDidTap:
            AnalyticsTaxonomy.missionSkipPopupSkipBtn
            state.isPresented = false
            if state.isDismiss {
                navigationRouter.pop()
            } else {
                navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: []))
            }
            
            
        case .makeMissionButtonDidTap:
            AnalyticsTaxonomy.makeMissionCompleteBtn
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: missionList))
            
        case .dismissAlert:
            AnalyticsTaxonomy.missionSkipPopupMissionBtn
            state.isPresented = false
            
        case .backButtonDidTap:
            state.isDismiss = true
            state.isPresented = true
        }
    }
}
