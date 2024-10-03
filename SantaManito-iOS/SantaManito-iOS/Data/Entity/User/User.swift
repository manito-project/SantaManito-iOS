//
//  User.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import Foundation

struct User: Hashable {
    let id: String
    let username: String
    //let manittoUserId: String? // TODO: manittoUserId 사용되는 값인지 확인 필요. 사용된다면 추가해야됨
}


extension User {
    static var stub1: User {
        return .init(id: "userID1", username: "류희둥")
    }
    
    static var stub2: User {
        return .init(id: "userID2", username: "장석쿵")
    }
    
    static var stub3: User {
        return .init(id: "userID3", username: "박상수")
    }
    
    static var stub4: User {
        return .init(id: "userID4", username: "이한나")
    }
}
