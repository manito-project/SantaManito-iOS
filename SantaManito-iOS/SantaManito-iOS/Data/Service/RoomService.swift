//
//  RoomService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//
import Foundation
import Combine

struct RoomInfo: Hashable {
    var id: String
    var roomName: String
    var invitationCode: String
    var createdAt: String
}

protocol RoomServiceType {
    func fetch() -> AnyPublisher<[RoomInfo], Error>
    func fetch(with roomID: String) -> AnyPublisher<RoomDetail, Error>
    func edit(with roomID: String) -> AnyPublisher<Void, Error>
    func delete(with roomID: String) -> AnyPublisher<Void, Error>
    
}

struct StubRoomService: RoomServiceType {
    
    func fetch() -> AnyPublisher<[RoomInfo], Error> {
        
        Future<[RoomInfo],Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                // Simulate success
                promise(.success([.init(id: "", roomName: "", invitationCode: "", createdAt: "")]))
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    func fetch(with roomID: String) -> AnyPublisher<RoomDetail, Error> {
        Just(.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func edit(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func delete(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
