//
//  MakeMissionViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation
import Combine

class MakeMissionViewModel: ObservableObject {
    
    //MARK: Action
    enum Action {
        case addMission(Mission)
        case deleteMission(Mission)
        case configMission
        case skipMissionButtonClicked
        case makeMissionButtonClicked
    }
    
    @Published var missionList: [Mission] = []
    
    @Published var makeMisstionButtonisEnabled: Bool = false
    
    func send(action: Action) {
        switch action {
        case .addMission(let mission):
            missionList.append(mission)
            
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            
        case .configMission:
            break
        case .skipMissionButtonClicked:
            break
        case .makeMissionButtonClicked:
            break
        }
    }
}

extension MakeMissionViewModel {
    func configMakeMissionButtonIsEnabled() {
        makeMisstionButtonisEnabled = !missionList.isEmpty
    }
}
