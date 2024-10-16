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
}


extension User {
    static var stub1: User {
        return .init(id: "userID1", username: "류희재")
    }
    
    static var stub2: User {
        return .init(id: "userID2", username: "장석우")
    }
    
    static var stub3: User {
        return .init(id: "userID3", username: "박상수")
    }
    
    static var stub4: User {
        return .init(id: "userID4", username: "이한나")
    }
}
