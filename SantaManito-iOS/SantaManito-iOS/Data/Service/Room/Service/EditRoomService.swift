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
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, SMNetworkError>
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, SMNetworkError>
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError>
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
}

extension EditRoomService: EditRoomServiceType {
    //TODO: 참여 방 조회하기면 홈에서 넘어오기 때문에 연결을 안해도 될거 같은데
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, SMNetworkError> {
        return Just(
            MakeRoomInfo(
                name: "마니또 방 이름",
                remainingDays: 10,
                dueDate: Date().adjustDays(remainingDays: 10)
            )
        ).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.editRoomInfo(roomID: roomID, request: request))
    }
    
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        requestWithResult(.createRoom(request: request), type: CreateRoomResult.self)
            .map { result  in result.invitationCode }
            .eraseToAnyPublisher()
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.deleteRoom(roomID: roomID))
    }
}

struct StubEditRoomService: EditRoomServiceType {
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, SMNetworkError> {
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, SMNetworkError> {
        return Just(
            MakeRoomInfo(
                name: "마니또 방 이름",
                remainingDays: 10,
                dueDate: Date().adjustDays(remainingDays: 10)
            )
        ).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        return Just("asdkf12").setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
}

