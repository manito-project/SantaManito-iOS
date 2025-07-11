//
//  AuthAPI.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/7/24.
//

import Foundation

enum AuthAPI {
    case signUp(request: SignUpRequest)
    case signIn(request: SignInRequest)
}

extension AuthAPI: BaseAPI {
    
    var path: String? {
        switch self {
        case .signUp:
            return "/auth/sign-up"
        case .signIn:
            return "/auth/sign-in"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        case .signIn:
            return .post
        }
    }
    
    var task: RequestTask {
        switch self {
        case .signUp(let request):
            return .requestJSONEncodable(request)
        case .signIn(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.noTokenHeader
    }
    
}
