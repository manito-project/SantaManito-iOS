//
//  CheckIRoomInfoViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import Foundation
import Combine

class CheckIRoomInfoViewModel: ObservableObject {

    enum Action {
        case load
        case makeRoomButtonClicked
        case deleteMission(Mission)
    }
    
    @Published var missionList: [Mission] = [
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기")
    ]
    @Published var deleteButtonIsEnabled: Bool = false

    func send(action: Action) {
        switch action {
        case .load:
            print("서버통신")
        case .makeRoomButtonClicked:
            break
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
        }
    }
}

extension CheckIRoomInfoViewModel {    
    func configDeleteButtonIsEnabled() {
        deleteButtonIsEnabled = missionList.count > 1
    }
}
