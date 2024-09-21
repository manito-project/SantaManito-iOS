//
//  EnterRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/21/24.
//

import Foundation
import Combine

enum EnterError: Error {
    case deletedRoomCode
    case invalidateCode
    case alreadyInRoomError
    case alreadyMatchedError
}

protocol EnterRoomServiceType {
    func validateParticipationCode(inviteCode: String) -> AnyPublisher<Void, EnterError>
}

struct StubEnterRoomService: EnterRoomServiceType {
    func validateParticipationCode(inviteCode: String) -> AnyPublisher<Void, EnterError> {
        return Just(()).setFailureType(to: EnterError.self).eraseToAnyPublisher()
        //Fail(error: EnterError.deletedRoomCode).eraseToAnyPublisher()
        //Fail(error: EnterError.invalidateCode).eraseToAnyPublisher()
        //Fail(error: EnterError.alreadyInRoomError).eraseToAnyPublisher()
        //Fail(error: EnterError.alreadyMatchedError).eraseToAnyPublisher()
    }
}


