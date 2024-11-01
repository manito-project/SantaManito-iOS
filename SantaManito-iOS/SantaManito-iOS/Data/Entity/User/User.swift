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

struct SantaUser: Hashable {
    let id: String
    let username: String
    let missionId: String
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

extension SantaUser {
    static var stub1: SantaUser {
        return .init(id: "userID1", username: "류희재", missionId: "1")
    }
    
    static var stub2: SantaUser {
        return .init(id: "userID2", username: "장석우" , missionId: "2")
    }
    
    static var stub3: SantaUser {
        return .init(id: "userID3", username: "박상수", missionId: "3")
    }
    
    static var stub4: SantaUser {
        return .init(id: "userID4", username: "이한나", missionId: "4")
    }
}

