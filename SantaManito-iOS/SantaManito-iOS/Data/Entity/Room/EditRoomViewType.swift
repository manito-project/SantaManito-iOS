//
//  EditRoomViewType.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/28/24.
//

import Foundation

enum EditRoomViewType: Hashable {
    case createMode
    case editMode(roomID: String, info: MakeRoomInfo)
    
    var title: String {
        switch self {
        case .createMode:
            return "방 정보 설정"
        case .editMode:
            return "방 정보 수정"
        }
    }
    
    
    
    var roomID: String? {
        switch self {
        case .createMode: // 생성시 roomID는 존재하지 않음
            return nil
        case let .editMode(roomID, _): // 수정 시 roomID 존재
            return roomID
        }
    }
    
    var info: MakeRoomInfo {
        switch self {
        case .createMode: //생성 시 기본 값으로 설정
            return .init(name: "",
                         totalDurationDays: 3,
                         dueDate: Date())
        case let .editMode(_, roomInfo): //수정 시 이전 값으로 가져옴
            return roomInfo
        }
    }
}
