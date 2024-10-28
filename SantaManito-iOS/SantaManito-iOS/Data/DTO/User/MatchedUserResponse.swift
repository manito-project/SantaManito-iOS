//
//  MatchedUserResponse.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/20/24.
//

import Foundation

struct MatchedUserResult: Decodable {
    let manitto: UserResponse
    let mission: MissionResponse
}

extension MatchedUserResult {
    func toEntity() -> (User, Mission) {
        return (manitto.toEntity(), mission.toEntity())
    }
}
