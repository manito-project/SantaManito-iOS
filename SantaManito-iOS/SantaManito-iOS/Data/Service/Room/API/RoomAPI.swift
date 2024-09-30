//
//  RoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

public enum EditRoomAPI {
    case getRoomInfo(roomID: String)
    case editRoomInfo(roomID: String, roomInfo: MakeRoomInfo)
    case createRoom(roomInfo: MakeRoomInfo, mission: [Mission])
}

extension EditRoomAPI: BaseAPI {
    public static var apiType: APIType = .editRoom
    
    var url: String {
        switch self {
        case .getRoomInfo(let roomID):
            <#code#>
        case .editRoomInfo(let roomID, let roomInfo):
            <#code#>
        case .createRoom(let roomInfo, let mission):
            <#code#>
        }
    }
    
    var path: String? {
        switch self {
        case .getRoomInfo(let roomID):
            <#code#>
        case .editRoomInfo(let roomID, let roomInfo):
            <#code#>
        case .createRoom(let roomInfo, let mission):
            <#code#>
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoomInfo(let roomID):
            <#code#>
        case .editRoomInfo(let roomID, let roomInfo):
            <#code#>
        case .createRoom(let roomInfo, let mission):
            <#code#>
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getRoomInfo(let roomID):
            <#code#>
        case .editRoomInfo(let roomID, let roomInfo):
            <#code#>
        case .createRoom(let roomInfo, let mission):
            <#code#>
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getRoomInfo(let roomID):
            <#code#>
        case .editRoomInfo(let roomID, let roomInfo):
            <#code#>
        case .createRoom(let roomInfo, let mission):
            <#code#>
        }
    }
    
    var encoder: any ParameterEncodable {
        <#code#>
    }
}
