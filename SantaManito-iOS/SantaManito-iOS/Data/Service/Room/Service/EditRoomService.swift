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
    func getRoomInfo(with roomID: String) -> AnyPublisher<GetRoomResponse, NetworkError>
    func editRoomInfo(with roomID: String, roomInfo: MakeRoomInfo) -> AnyPublisher<Void, NetworkError>
    func createRoom(roomInfo: MakeRoomInfo, missions: [Mission]) -> AnyPublisher<String, NetworkError>
}

extension EditRoomService: EditRoomServiceType {
    func getRoomInfo(with roomID: String) -> AnyPublisher<GetRoomResponse, NetworkError> {
        request(.getRoomInfo(roomID: roomID))
    }
    
    func editRoomInfo(with roomID: String, roomInfo: MakeRoomInfo) -> AnyPublisher<Void, NetworkError> {
        return Just(()).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    func createRoom(roomInfo: MakeRoomInfo, missions: [Mission]) -> AnyPublisher<String, NetworkError> {
        return Just("asdkf12").setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
}

struct GetRoomResponse: Decodable {
    var userId: String
    var manittoUserId: String?
    var mission: String?
}

struct StubEditRoomService: EditRoomServiceType {
    func editRoomInfo(with roomID: String, roomInfo: MakeRoomInfo) -> AnyPublisher<Void, NetworkError> {
        return Just(()).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<GetRoomResponse, NetworkError> {
        return Just(GetRoomResponse(userId: "1")).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
//        return Just(
//            MakeRoomInfo(
//                name: "마니또 방 이름",
//                remainingDays: 10,
//                dueDate: Date().adjustDays(remainingDays: 10)
//            )
//        ).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func createRoom(roomInfo: MakeRoomInfo, missions: [Mission]) -> AnyPublisher<String, NetworkError> {
        return Just("asdkf12").setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
}

