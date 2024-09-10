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
        case configMission
        case skipMissionButtonClicked
        case makeMissionButtonClicked
    }

    @Published var missionList: [Mission] = [Mission(content: "")]
    @Published var makeMisstionButtonisEnabled: Bool = false

    func send(action: Action) {
        switch action {
        case .addMission:
            let newMission = Mission(content: "")
            missionList.append(newMission)
            
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
