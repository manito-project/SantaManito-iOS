//
//  EditRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/20/24.
//

import Foundation
import Combine

typealias EditRoomService = BaseService<RoomAPI>

protocol EditRoomServiceType {
//    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError>
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, SMNetworkError>
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError>
    
    func getRoomMyInfo(with roomID: String) -> AnyPublisher<RoomMyInfoResult, SMNetworkError>
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
    
    func enterRoom(inviteCode: String) -> AnyPublisher<String, EnterError>
    func exitRoom(roomID: String) -> AnyPublisher<Void, SMNetworkError>
}

extension EditRoomService: EditRoomServiceType {
    //TODO: 참여 방 조회하기면 홈에서 넘어오기 때문에 연결을 안해도 될거 같은데
//    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError> {
//        return Just(
//            MakeRoomInfo(
//                name: "마니또 방 이름",
//                remainingDays: 10,
//                dueDate: Date().adjustDays(remainingDays: 10)
//            )
//        ).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
//    }
    
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.editRoomInfo(roomID: roomID, request: request))
    }
    
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        requestWithResult(.createRoom(request: request), type: CreateRoomResult.self)
            .map { result  in result.invitationCode }
            .eraseToAnyPublisher()
    }
    
    func getRoomMyInfo(with roomID: String) -> AnyPublisher<RoomMyInfoResult, SMNetworkError> {
        requestWithResult(.getMyInfo(roomID: roomID), type: RoomMyInfoResult.self)
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.deleteRoom(roomID: roomID))
    }
    
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.deleteHistoryRoom(roomID: roomID))
    }
    
    func enterRoom(inviteCode: String) -> AnyPublisher<String, EnterError> {
        requestWithResult(
            .enterRoom(request: EnterRoomRequest(inviteCode: inviteCode)),
            type: EnterRoomResult.self
        )
        //TODO: 여기 수정하기
        .mapError { smError -> EnterError in
                switch smError {
                case .invalidResponse(let responseError):
                    if case let .invalidStatusCode(code, _) = responseError {
                        return EnterError.error(with: code)
                    }
                    return .unknown
                    
                default:
                    return .unknown
                }
            }
        .map { result in result.roomId }
        .eraseToAnyPublisher()
    }
    
    func exitRoom(roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.exitRoom(roomID: roomID))
    }
}

struct StubEditRoomService: EditRoomServiceType {
    func getRoomMyInfo(with roomID: String) -> AnyPublisher<RoomMyInfoResult, SMNetworkError> {
        return Just(RoomMyInfoResult(manitto: .stub1, mission: Mission(content: "asdf", id: UUID())))
            .setFailureType(to: SMNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, SMNetworkError> {
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
//    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError> {
//        return Just(
//            MakeRoomInfo(
//                name: "마니또 방 이름",
//                remainingDays: 10,
//                dueDate: Date().adjustDays(remainingDays: 10)
//            )
//        ).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
//    }
    
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        return Just("asdkf12").setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func enterRoom(inviteCode: String) -> AnyPublisher<String, EnterError> {
        return Just("roomId").setFailureType(to: EnterError.self).eraseToAnyPublisher()
    }
    
    func exitRoom(roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
}

