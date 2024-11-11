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
        case dismissAlert
    }
    
    struct State { 
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
            missionList.append(Mission(content: ""))
            
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .skipMissionButtonDidTap:
            state.isPresented = true
            
        case .ignoreMissionButtonDidTap:
            state.isPresented = false
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: []))
            
        case .makeMissionButtonDidTap:
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: missionList))

        case .dismissAlert:
            state.isPresented = false
        }
    }
}
