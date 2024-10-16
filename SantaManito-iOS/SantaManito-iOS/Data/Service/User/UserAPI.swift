//
//  UserAPI.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/16/24.
//

import Foundation


enum UserAPI {
    case editNickname(request: EditNicknameReqeust)
    case getUserInfo(userID: String)
    case deleteAccount
}

extension UserAPI: BaseAPI {
    
    var path: String? {
        switch self {
        case .editNickname:
            Paths.editNickName
        case .getUserInfo:
            Paths.getUserData
        case .deleteAccount:
            Paths.deleteAccount
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .editNickname:
            return .put
        case .getUserInfo:
            return .get
        case .deleteAccount:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .editNickname(let reqeust):
            return .requestJSONEncodable(reqeust)
        case .getUserInfo(let userID):
            return .requestParameters(["userIds": userID])
        case .deleteAccount:
            return .requestPlain
        }
    }
}
