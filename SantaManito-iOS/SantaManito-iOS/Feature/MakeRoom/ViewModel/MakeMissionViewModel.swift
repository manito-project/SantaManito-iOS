//
//  MakeMissionViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation
import Combine

class MakeMissionViewModel: ObservableObject {

    enum Action {
        case addMission
        case deleteMission(Mission)
        case editMission
        case skipMissionButtonClicked
        case makeMissionButtonClicked
        case ignoreMissionButtonClicked
        case dismissAlert
    }

    @Published var missionList: [Mission] = [Mission(content: "")]
    @Published var makeMisstionButtonisEnabled: Bool = false
    @Published var deleteButtonIsEnabled: Bool = false
    @Published var alertPresented: Bool = false

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
            alertPresented = true
            
        case .ignoreMissionButtonClicked:
            print("방 정보 확인 창으로 넘어갈거야!")
            
        case .makeMissionButtonClicked:
            print("방 정보 확인 창으로 넘어갈거야!")

        case .dismissAlert:
            alertPresented = false
        }
    }
}

extension MakeMissionViewModel {
    func configMakeMissionButtonIsEnabled() {
        for mission in missionList {
            if mission.content.count < 1 {
                makeMisstionButtonisEnabled = false
                return
            }
        }
        
        makeMisstionButtonisEnabled = true
    }
    
    func configDeleteButtonIsEnabled() {
        deleteButtonIsEnabled = missionList.count > 1
    }
}
