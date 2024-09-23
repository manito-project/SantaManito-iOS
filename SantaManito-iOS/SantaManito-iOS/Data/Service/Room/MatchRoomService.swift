//
//  MatchRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/23/24.
//

import Foundation
import Combine

struct ManitoUser {
    var manito: String
    var mission: String
}

extension ManitoUser {
    static var stub1: ManitoUser {
        .init(manito: "류희재", mission: "다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고다고ㅍ")
    }
}

protocol MatchRoomServiceType {
    func matchPlayer() -> AnyPublisher<Void, Error>
    func getManito(_ userID: String) -> AnyPublisher<ManitoUser, Error>
}

struct StubMatchRoomService: MatchRoomServiceType {
    
    func matchPlayer() -> AnyPublisher<Void, Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getManito(_ userID: String) -> AnyPublisher<ManitoUser, Error> {
        return Just(.stub1).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}


