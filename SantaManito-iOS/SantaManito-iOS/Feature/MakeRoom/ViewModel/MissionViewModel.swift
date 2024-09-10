//
//  MissionViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation

class MissionViewModel: ObservableObject {
    @Published var mission: Mission
    
    init(mission: Mission) {
        self.mission = mission
    }
}
