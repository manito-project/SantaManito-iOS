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
        case skipMissionButtonClicked
        case makeMissionButtonClicked
        case ignoreMissionButtonClicked
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
          .map { $0.allSatisfy { $0.content.count >= 1 } }
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
            
        case .skipMissionButtonClicked:
            state.isPresented = true
            
        case .ignoreMissionButtonClicked, .makeMissionButtonClicked:
            state.isPresented = false
            navigationRouter.push(to: .roomInfo(roomInfo: roomInfo, missionList: missionList)) //TODO: string.empty인 미션도 같이 넘어가는 오류 해결해야함.

        case .dismissAlert:
            state.isPresented = false
        }
    }
}
