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
    func enterRoom(at: String) -> AnyPublisher<String, EnterError>
    func exitRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError>
    func getMyInfo(with roomID: String) -> AnyPublisher<(User, Mission) , SMNetworkError>
}

extension RoomService: RoomServiceType {
    // For All
    func getEnteredRooms() -> AnyPublisher<[RoomDetail], SMNetworkError> {
        requestWithResult(.getEnteredAllRoom, [RoomDetailResponse].self)
            .map {
                $0.map { $0.toEntity() }.sorted()
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
    
    // For Host
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
    
    // For Guset
    func enterRoom(at invitationCode: String) -> AnyPublisher<String, EnterError> {
        requestWithResult(.enterRoom(request: .init(invitationCode: invitationCode)), EnterRoomResult.self)
            .map { $0.roomId }
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
            .eraseToAnyPublisher()
    }
    
    func exitRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.exitRoom(roomID: roomID))
    }
    
    func getMyInfo(with roomID: String) -> AnyPublisher<(User, Mission), SMNetworkError> {
        requestWithResult(.getMyInfo(roomID: roomID), MatchedUserResult.self)
            .map { $0.toEntity() }
            .eraseToAnyPublisher()
    }
}

struct StubRoomService: RoomServiceType {
    // For All
    func getEnteredRooms() -> AnyPublisher<[RoomDetail], SMNetworkError> {
//        Just([.stub1, .stub2, .stub3, .stub4, .stub5].sorted()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
        Just([].sorted()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func getRoomInfo(with roomID: String) -> AnyPublisher<RoomDetail, SMNetworkError> {
        Just(.stub1).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func deleteHistoryRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    // For Host
    func createRoom(request: CreateRoomRequest) -> AnyPublisher<String, SMNetworkError> {
        Just("초대코드1").setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func editRoomInfo(with roomID: String, info: MakeRoomInfo) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func matchRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Fail<Void, SMNetworkError>(error: SMNetworkError.invalidResponse(.invalidStatusCode(code: 400, data: "")))
            .delay(for: .seconds(3), scheduler: RunLoop.current)
            .eraseToAnyPublisher()
    }
    
    func deleteRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    // For Guest
    func enterRoom(at invitationCode: String) -> AnyPublisher<String, EnterError> {
        Just("roomID1").setFailureType(to: EnterError.self).eraseToAnyPublisher()
    }
    
    func exitRoom(with roomID: String) -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    func getMyInfo(with roomID: String) -> AnyPublisher<(User, Mission), SMNetworkError> {
        Just((.stub1, .stub1)).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
}
