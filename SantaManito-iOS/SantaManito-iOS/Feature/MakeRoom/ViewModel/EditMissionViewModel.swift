//
//  MakeMissionViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation
import Combine

class EditMissionViewModel: ObservableObject {

    enum Action {
        case addMission
        case deleteMission(Mission)
        case editMission
        case skipMissionButtonClicked
        case makeMissionButtonClicked
        case ignoreMissionButtonClicked
        case dismissAlert
    }
    
    @Published private(set) var state = State(
        isEnabled: false,
        isPresented: false,
        canDelete: false
    )
    
    struct State {
        var isEnabled: Bool
        var isPresented: Bool
        var canDelete: Bool
    }

    @Published var missionList: [Mission] = [Mission(content: "")]

    func send(action: Action) {
        switch action {
        case .addMission:
            let newMission = Mission(content: "")
            missionList.append(newMission)
            configDeleteButtonIsEnabled()
            configMakeMissionButtonIsEnabled()
            
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            configDeleteButtonIsEnabled()
            configMakeMissionButtonIsEnabled()
            
        case .editMission:
            configMakeMissionButtonIsEnabled()
            
        case .skipMissionButtonClicked:
            state.isPresented = true
            
        case .ignoreMissionButtonClicked:
            print("방 정보 확인 창으로 넘어갈거야!")
            
        case .makeMissionButtonClicked:
            print("방 정보 확인 창으로 넘어갈거야!")

        case .dismissAlert:
            state.isPresented = false
        }
    }
}

extension EditMissionViewModel {
    func configMakeMissionButtonIsEnabled() {
        for mission in missionList {
            if mission.content.count < 1 {
                state.isEnabled = false
                return
            }
        }
        
        state.isEnabled = true
    }
    
    func configDeleteButtonIsEnabled() {
        state.canDelete = missionList.count > 1
    }
}
