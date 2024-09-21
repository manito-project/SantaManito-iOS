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
    func getParticipate(_ roomID: String) -> AnyPublisher<[Participate], Error>
    func getUser(_ userID: String) -> AnyPublisher<Bool, Error>
    func getInviteCode(_ roomID: String) -> AnyPublisher<String, Error>
}

struct StubEnterRoomService: EnterRoomServiceType {
    func validateParticipationCode(inviteCode: String) -> AnyPublisher<Void, EnterError> {
        return Just(()).setFailureType(to: EnterError.self).eraseToAnyPublisher()
//        return Fail(error: EnterError.deletedRoomCode).eraseToAnyPublisher()
//        return Fail(error: EnterError.invalidateCode).eraseToAnyPublisher()
//        return Fail(error: EnterError.alreadyInRoomError).eraseToAnyPublisher()
//        return Fail(error: EnterError.alreadyMatchedError).eraseToAnyPublisher()
    }
    
    func getParticipate(_ roomID: String) -> AnyPublisher<[Participate], Error> {
        return Just(Participate.dummy()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getUser(_ userID: String) -> AnyPublisher<Bool, Error> {
        return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
//        return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getInviteCode(_ roomID: String) -> AnyPublisher<String, Error> {
        return Just("초대코드쓰껄").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}


