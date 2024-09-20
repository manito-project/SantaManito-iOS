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
        case updateMissionContent
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
    
    //MARK: - Properties
    
    @Published private(set) var state = State()
    @Published var missionList: [Mission] = [Mission(content: "")]

    //MARK: - Methods
    
    func send(action: Action) {
        switch action {
        case .addMission:
            missionList.append(Mission(content: ""))
            updateState()
            
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
            updateState()
            
        case .updateMissionContent:
            updateState()
            
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
    
    private func updateState() {
        configMakeMissionButtonIsEnabled()
        configDeleteButtonIsEnabled()
    }
}

extension EditMissionViewModel {
    func configMakeMissionButtonIsEnabled() {
        state.isEnabled = missionList.allSatisfy { $0.content.count >= 1 }
    }
    
    func configDeleteButtonIsEnabled() {
        state.canDelete = missionList.count > 1
    }
}
