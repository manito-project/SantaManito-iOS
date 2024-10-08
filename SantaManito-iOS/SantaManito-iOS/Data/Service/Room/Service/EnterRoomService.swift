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
    func enterRoom(inviteCode: String) -> AnyPublisher<String, EnterError>
}

extension EnterRoomService: EnterRoomServiceType {
    func enterRoom(inviteCode: String) -> AnyPublisher<String, EnterError> {
        requestWithResult(
            .enterRoom(request: EnterRoomRequest(inviteCode: inviteCode)),
            type: EnterRoomResult.self
        )
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
        .map { result in result.roomId }
        .eraseToAnyPublisher()
    }
}
struct StubEnterRoomService: EnterRoomServiceType {
    func enterRoom(inviteCode: String) -> AnyPublisher<String, EnterError> {
        return Just("roomId").setFailureType(to: EnterError.self).eraseToAnyPublisher()
    }
}


