//
//  EditRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/20/24.
//

import Foundation
import Combine

typealias EditRoomService = BaseService<EditRoomAPI>

protocol EditRoomServiceType {
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, NetworkError>
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, NetworkError>
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, NetworkError>
}

extension EditRoomService: EditRoomServiceType {
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, NetworkError> {
        return Just(
            MakeRoomInfo(
                name: "마니또 방 이름",
                remainingDays: 10,
                dueDate: Date().adjustDays(remainingDays: 10)
            )
        ).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, NetworkError> {
        requestWithNoResult(.editRoomInfo(roomId: roomID, request: request))
    }
    
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, NetworkError> {
        requestWithResult(.createRoom(request: request))
    }
}

struct StubEditRoomService: EditRoomServiceType {
    func editRoomInfo(with roomID: String, request: EditRoomRequest) -> AnyPublisher<Void, NetworkError> {
        return Just(()).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, NetworkError> {
        return Just(
            MakeRoomInfo(
                name: "마니또 방 이름",
                remainingDays: 10,
                dueDate: Date().adjustDays(remainingDays: 10)
            )
        ).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    func createRoom(_ request: CreateRoomRequest) -> AnyPublisher<String, NetworkError> {
        return Just("asdkf12").setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
}

