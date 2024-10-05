//
//  EnterRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/21/24.
//

import Foundation
import Combine

typealias EnterRoomService = BaseService<RoomAPI>

protocol EnterRoomServiceType {
    func enterRoom(inviteCode: String) -> AnyPublisher<Void, EnterError>
    //    func getParticipate(_ roomID: String) -> AnyPublisher<[Participate], Error>
    func getUser(_ userID: String) -> AnyPublisher<Bool, Error>
    func getInviteCode(_ roomID: String) -> AnyPublisher<String, Error>
}

extension EnterRoomService: EnterRoomServiceType {
    func enterRoom(inviteCode: String) -> AnyPublisher<Void, EnterError> {
        requestWithNoResult(.enterRoom(request: EnterRoomRequest(inviteCode: inviteCode)))
            .mapError { smError -> EnterError in
                    switch smError {
                    case .invalidResponse(let responseError):
                        if case let .invalidStatusCode(code, _) = responseError {
                            return EnterError.error(with: code)! //TODO: 강제 옵셔널 처리 괜찮을지..?
                        }
                        return .unknown(smError)

                    default:
                        return .unknown(smError)
                    }
                }
                .flatMap { _ in Just(()).setFailureType(to: EnterError.self) }
                .eraseToAnyPublisher()
    }
    
    func getUser(_ userID: String) -> AnyPublisher<Bool, any Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getInviteCode(_ roomID: String) -> AnyPublisher<String, any Error> {
        return Just("초대코드쓰껄").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    
}
struct StubEnterRoomService: EnterRoomServiceType {
    func enterRoom(inviteCode: String) -> AnyPublisher<Void, EnterError> {
        return Just(()).setFailureType(to: EnterError.self).eraseToAnyPublisher()
        //        return Fail(error: EnterError.deletedRoomCode).eraseToAnyPublisher()
        //        return Fail(error: EnterError.invalidateCode).eraseToAnyPublisher()
        //        return Fail(error: EnterError.alreadyInRoomError).eraseToAnyPublisher()
        //        return Fail(error: EnterError.alreadyMatchedError).eraseToAnyPublisher()
    }
    
    //    func getParticipate(_ roomID: String) -> AnyPublisher<[Participate], Error> {
    //        return Just(Participate.dummy()).setFailureType(to: Error.self).eraseToAnyPublisher()
    //    }
    //
    func getUser(_ userID: String) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
        //        return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getInviteCode(_ roomID: String) -> AnyPublisher<String, Error> {
        return Just("초대코드쓰껄").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}


