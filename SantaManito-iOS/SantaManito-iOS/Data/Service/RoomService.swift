//
//  RoomService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//
import Foundation
import Combine

protocol RoomServiceType {
    func fetchAll() -> AnyPublisher<[RoomDetail], Error>
    func fetch(with roomID: String) -> AnyPublisher<RoomDetail, Error>
    func edit(with roomID: String) -> AnyPublisher<Void, Error>
    func delete(with roomID: String) -> AnyPublisher<Void, Error>
    
}

struct StubRoomService: RoomServiceType {
    
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
