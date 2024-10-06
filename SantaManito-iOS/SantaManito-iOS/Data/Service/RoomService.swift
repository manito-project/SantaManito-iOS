//
//  RoomService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//
import Foundation
import Combine

protocol RoomServiceType {
    
    // All
    func fetchAll() -> AnyPublisher<[RoomDetail], Error>
    func fetch(with roomID: String) -> AnyPublisher<RoomDetail, Error>
    func exit(with roomID: String) -> AnyPublisher<Void, Error>
    
    
    // Creator
    func create(with info: MakeRoomInfo) -> AnyPublisher<String, Error>
    func edit(with roomID: String) -> AnyPublisher<Void, Error>
    func delete(with roomID: String) -> AnyPublisher<Void, Error>
    
    
    // Guest
    func enter(at invitationCode: String) -> AnyPublisher<Void,Error>
}

struct StubRoomService: RoomServiceType {
    func exit(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func enter(at invitationCode: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    

    
    func create(with info: MakeRoomInfo) -> AnyPublisher<String, Error> {
        Just("초대코드1").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    
    func fetchAll() -> AnyPublisher<[RoomDetail], Error> {
        Future<[RoomDetail],Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success([.stub1, .stub2, .stub3, .stub4, .stub5]))
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    func fetch(with roomID: String) -> AnyPublisher<RoomDetail, Error> {
        Future<RoomDetail,Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success(.stub1))
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    func edit(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func delete(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
