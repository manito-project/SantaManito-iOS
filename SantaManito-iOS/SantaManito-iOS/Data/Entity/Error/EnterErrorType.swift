//
//  EnterErrorType.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/6/24.
//

import Foundation

enum EnterError: Error {
    case deletedRoomCode
    case invalidateCode
    case alreadyInRoomError
    case alreadyMatchedError
    case unknown
    
    var description: String {
        switch self {
            
        case .deletedRoomCode:
            return "이미 삭제된 방입니다"
        case .invalidateCode:
            return "입장 코드가 일치하지 않습니다"
        case .alreadyInRoomError:
            return "이미 참여된 방입니다"
        case .alreadyMatchedError:
            return "이미 매칭된 방입니다"
        case .unknown:
            return "알 수 없는 에러입니다"
        }
    }
}

extension EnterError {
    static func error(with statusCode: Int?) -> EnterError {
        switch statusCode {
        case 404:
            return .invalidateCode   // 예시: 방 코드를 찾을 수 없을 때
        case 410:
            return .deletedRoomCode  // 예시: 방 코드가 삭제되었을 때
        case 409:
            return .alreadyInRoomError  // 예시: 이미 방에 참가된 경우
        case 412:
            return .alreadyMatchedError // 예시: 이미 매칭이 완료된 경우
        default:
            return .unknown
        }
    }
}
