//
//  RoomService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//
import Foundation
import Combine

typealias RoomService = BaseService<RoomAPI>

protocol RoomServiceType {
    
    // For All
    func getEnteredRooms() -> AnyPublisher<[RoomDetail], SMNetworkError>
    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError>
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
    
    // For Host
    func createRoom(request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError>
    func editRoomInfo(with roomID: String, info: MakeRoomInfo) -> AnyPublisher<Void, SMNetworkError>
    func matchRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
    
    
    // For Guset
    func enterRoom(at: String) -> AnyPublisher<String, SMNetworkError>
    func exitRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
//    func getMyInfo(roomID: String) -> AnyPublisher<Void, SMNetworkError>
}

extension RoomService: RoomServiceType {
    func getEnteredRooms() -> AnyPublisher<[RoomDetail], SMNetworkError> {
        requestWithResult(.getEnteredAllRoom, [RoomDetailResponse].self)
            .map {
                $0.map { $0.toEntity() }
                    .sorted { $0.expirationDate < $1.expirationDate }
            }
            .eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError> {
        requestWithResult(.getRoomInfo(roomID: roomID), RoomDetailResponse.self)
            .map { $0.toEntity() }
            .eraseToAnyPublisher()
    }
    
    
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.deleteHistoryRoom(roomID: roomID))
    }
    
    func createRoom(request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        requestWithResult(.createRoom(request: request), CreateRoomResult.self)
            .map { $0.invitationCode }
            .eraseToAnyPublisher()
    }
    
    func editRoomInfo(with roomID: String, info: MakeRoomInfo) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.editRoomInfo(roomID: roomID, request: .init(info)))
    }
    
    func matchRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.matchRoom(roomID: roomID))
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.deleteRoom(roomID: roomID))
    }
    
    func enterRoom(at invitationCode: String) -> AnyPublisher<String, SMNetworkError> {
        requestWithResult(.enterRoom(request: .init(invitationCode: invitationCode)), EnterRoomResult.self)
            .map { $0.roomId }
            .eraseToAnyPublisher()
    }
    
    func exitRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.exitRoom(roomID: roomID))
    }
    
    
}

struct StubRoomService: RoomServiceType {
    
    func getEnteredRooms() -> AnyPublisher<[RoomDetail], SMNetworkError> {
        Just([.stub1, .stub2, .stub3, .stub4, .stub5]).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError> {
        Just(.stub1).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func createRoom(request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        Just("초대코드1").setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func editRoomInfo(with roomID: String, info: MakeRoomInfo) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func matchRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func enterRoom(at invitationCode: String) -> AnyPublisher<String, SMNetworkError> {
        Just("roomID1").setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func exitRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    
}
