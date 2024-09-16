//
//  RoomService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//
import Foundation
import Combine

struct RoomRequest { }

struct RoomInfo { }

struct RoomDetailInfo { }


protocol RoomServiceType {
    func create(_ request: RoomRequest) -> AnyPublisher<String, Error>
    func fetch() -> AnyPublisher<[RoomInfo], Error>
    func fetch(with roomID: String) -> AnyPublisher<RoomDetailInfo, Error>
    func edit(with roomID: String) -> AnyPublisher<Void, Error>
    func delete(with roomID: String) -> AnyPublisher<Void, Error>
    
}

struct StubRoomService: RoomServiceType {
    func create(_ request: RoomRequest) -> AnyPublisher<String, Error> {
        Just("방식별자ID").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func fetch() -> AnyPublisher<[RoomInfo], Error> {
        Just([RoomInfo(), RoomInfo()]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func fetch(with roomID: String) -> AnyPublisher<RoomDetailInfo, Error> {
        Just(RoomDetailInfo()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func edit(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func delete(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    

}
