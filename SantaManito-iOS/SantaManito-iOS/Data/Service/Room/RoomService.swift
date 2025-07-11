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
    func getEnteredRooms() async throws -> [RoomDetail]
    func getRoomInfo(with roomID: String) async throws -> RoomDetail
    func deleteHistoryRoom(with roomID: String) async throws
    
    // For Host
    func createRoom(roomRequest: CreateRoomRequest) async throws -> String
    func editRoomInfo(with roomID: String, info: MakeRoomInfo) async throws
    func matchRoom(with roomID: String) async throws
    func deleteRoom(with roomID: String) async throws
    
    
    // For Guset
    func enterRoom(at: String) async throws -> String
    func exitRoom(with roomID: String) async throws
    func getMyInfo(with roomID: String) async throws -> (User, Mission)
}

extension RoomService: RoomServiceType {
    // For All
    func getEnteredRooms() async throws -> [RoomDetail] {
        let data = try await request(.getEnteredAllRoom, as: [RoomDetailResponse].self)
        return data.map { $0.toEntity() }.sorted()
    }
    
    func getRoomInfo(with roomID: String) async throws -> RoomDetail {
        let data = try await request(.getRoomInfo(roomID: roomID), as: RoomDetailResponse.self)
        return data.toEntity()
    }
    
    
    func deleteHistoryRoom(with roomID: String) async throws {
        try await request(.deleteHistoryRoom(roomID: roomID))
    }
    
    // For Host
    func createRoom(roomRequest: CreateRoomRequest) async throws -> String {
        let data = try await request(.createRoom(request: roomRequest), as: CreateRoomResult.self)
        return data.invitationCode
    }
    
    func editRoomInfo(with roomID: String, info: MakeRoomInfo) async throws {
        try await request(.editRoomInfo(roomID: roomID, request: .init(info)))
    }
    
    func matchRoom(with roomID: String) async throws {
        try await request(.matchRoom(roomID: roomID))
    }
    
    func deleteRoom(with roomID: String) async throws {
        try await request(.deleteRoom(roomID: roomID))
    }
    
    // For Guset
    func enterRoom(at invitationCode: String) async throws -> String {
        do {
            let data = try await request(.enterRoom(request: .init(invitationCode: invitationCode)), as: EnterRoomResult.self)
            return data.roomId
        } catch let smError as SMNetworkError {
            switch smError {
            case .invalidResponse(let responseError):
                if case let .invalidStatusCode(code, _) = responseError {
                    throw EnterError.error(with: code)
                }
                throw EnterError.unknown
            default:
                throw EnterError.unknown
            }
        }
    }
    
    func exitRoom(with roomID: String) async throws {
        try await request(.exitRoom(roomID: roomID))
    }
    
    func getMyInfo(with roomID: String) async throws -> (User, Mission) {
        let data = try await request(.getMyInfo(roomID: roomID), as: MatchedUserResult.self)
        return data.toEntity()
    }
}

struct StubRoomService: RoomServiceType {
    
    // For All
    func getEnteredRooms() async throws -> [RoomDetail] {
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3초 지연
        return [] // 또는 [.stub1, .stub2, ...] 등으로 교체 가능
    }

    func getRoomInfo(with roomID: String) async throws -> RoomDetail {
        try await Task.sleep(nanoseconds: 300_000_000)
        return .stub1
    }

    func deleteHistoryRoom(with roomID: String) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    // For Host
    func createRoom(roomRequest: CreateRoomRequest) async throws -> String {
        try await Task.sleep(nanoseconds: 300_000_000)
        return "초대코드1"
    }

    func editRoomInfo(with roomID: String, info: MakeRoomInfo) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    func matchRoom(with roomID: String) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
        // 실패 시뮬레이션 (선택사항)
        throw SMNetworkError.invalidResponse(.invalidStatusCode(code: 400, data: ""))
    }

    func deleteRoom(with roomID: String) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    // For Guest
    func enterRoom(at invitationCode: String) async throws -> String {
        try await Task.sleep(nanoseconds: 300_000_000)
        return "roomID1"
    }

    func exitRoom(with roomID: String) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    func getMyInfo(with roomID: String) async throws -> (User, Mission) {
        try await Task.sleep(nanoseconds: 300_000_000)
        return (.stub1, .stub1)
    }
}

