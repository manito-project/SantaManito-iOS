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
        case addMissionButtonClicked
        case clearButtonClicked
        case configMission
        case skipMissionButtonClicked
        case makeMissionButtonClicked
    }
    
    @Published var mission: String = ""
    @Published var missionList: [String] = ["123", "123" , "!@3", "!@#42"]
    
    func send(action: Action) {
        switch action {
        case .addMissionButtonClicked:
            break
        case .clearButtonClicked:
            break
        case .configMission:
            break
        case .skipMissionButtonClicked:
            break
        case .makeMissionButtonClicked:
            break
        }
    }
}
