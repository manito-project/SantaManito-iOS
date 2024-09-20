//
//  EditRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/20/24.
//

import Foundation
import Combine


protocol EditRoomServiceType {
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, Error>
    func editRoomInfo(with roomID: String, roomInfo: MakeRoomInfo) -> AnyPublisher<Void, Error>
    func createRoom(roomInfo: MakeRoomInfo, missions: [Mission]) -> AnyPublisher<Void, Error>
}

struct StubEditRoomService: EditRoomServiceType {
    func editRoomInfo(with roomID: String, roomInfo: MakeRoomInfo) -> AnyPublisher<Void, any Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<MakeRoomInfo, Error> {
        return Just(
            MakeRoomInfo(
                name: "마니또 방 이름",
                remainingDays: 10,
                dueDate: Date()
            )
        ).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func createRoom(roomInfo: MakeRoomInfo, missions: [Mission]) -> AnyPublisher<Void, any Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}

