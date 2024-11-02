//
//  RoomStateFactory.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/14/24.
//

import Foundation

struct RoomStateFactory {
    static func create(_ dto: RoomDetailResponse) -> RoomState {
        guard dto.deletedByCreatorDate == nil else { return .deleted }
        guard dto.expirationDate > Date() else { return dto.matchingDate == nil ? .expired : .completed }  
        guard dto.matchingDate != nil else { return .notStarted }
        return .inProgress
    }
}
