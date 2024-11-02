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
    let missionId: String?
}


extension User {
    static var stub1: User {
        return .init(id: "user_id_1", username: "유저1")
    }

    static var stub2: User {
        return .init(id: "user_id_2", username: "유저2")
    }

    static var stub3: User {
        return .init(id: "user_id_3", username: "유저3")
    }

    static var stub4: User {
        return .init(id: "user_id_4", username: "유저4")
    }

    static var stub5: User {
        return .init(id: "user_id_5", username: "유저5")
    }

    static var stub6: User {
        return .init(id: "user_id_6", username: "유저6")
    }

    static var stub7: User {
        return .init(id: "user_id_7", username: "유저7")
    }

    static var stub8: User {
        return .init(id: "user_id_8", username: "유저8")
    }

    static var stub9: User {
        return .init(id: "user_id_9", username: "유저9")
    }

    static var stub10: User {
        return .init(id: "user_id_10", username: "유저10")
    }

    static var stub11: User {
        return .init(id: "user_id_11", username: "유저11")
    }

    static var stub12: User {
        return .init(id: "user_id_12", username: "유저12")
    }

    static var stub13: User {
        return .init(id: "user_id_13", username: "유저13")
    }

    static var stub14: User {
        return .init(id: "user_id_14", username: "유저14")
    }

    static var stub15: User {
        return .init(id: "user_id_15", username: "유저15")
    }

    static var stub16: User {
        return .init(id: "user_id_16", username: "유저16")
    }

    static var stub17: User {
        return .init(id: "user_id_17", username: "유저17")
    }
}

extension SantaUser {
    static var stub1: SantaUser {
        return .init(id: "user_id_1", username: "유저1", missionId: Mission.stub1.id)
    }

    static var stub2: SantaUser {
        return .init(id: "user_id_2", username: "유저2", missionId: Mission.stub2.id)
    }

    static var stub3: SantaUser {
        return .init(id: "user_id_3", username: "유저3", missionId: Mission.stub3.id)
    }

    static var stub4: SantaUser {
        return .init(id: "user_id_4", username: "유저4", missionId: Mission.stub4.id)
    }

    static var stub5: SantaUser {
        return .init(id: "user_id_5", username: "유저5", missionId: Mission.stub5.id)
    }

    static var stub6: SantaUser {
        return .init(id: "user_id_6", username: "유저6", missionId: Mission.stub6.id)
    }

    static var stub7: SantaUser {
        return .init(id: "user_id_7", username: "유저7", missionId: Mission.stub7.id)
    }

    static var stub8: SantaUser {
        return .init(id: "user_id_8", username: "유저8", missionId: Mission.stub8.id)
    }

    static var stub9: SantaUser {
        return .init(id: "user_id_9", username: "유저9", missionId: Mission.stub9.id)
    }

    static var stub10: SantaUser {
        return .init(id: "user_id_10", username: "유저10", missionId: Mission.stub10.id)
    }

    static var stub11: SantaUser {
        return .init(id: "user_id_11", username: "유저11", missionId: Mission.stub11.id)
    }

    static var stub12: SantaUser {
        return .init(id: "user_id_12", username: "유저12", missionId: Mission.stub12.id)
    }

    static var stub13: SantaUser {
        return .init(id: "user_id_13", username: "유저13", missionId: Mission.stub13.id)
    }

    static var stub14: SantaUser {
        return .init(id: "user_id_14", username: "유저14", missionId: Mission.stub14.id)
    }

    static var stub15: SantaUser {
        return .init(id: "user_id_15", username: "유저15", missionId: Mission.stub15.id)
    }

    static var stub16: SantaUser {
        return .init(id: "user_id_16", username: "유저16", missionId: Mission.stub16.id)
    }

    static var stub17: SantaUser {
        return .init(id: "user_id_17", username: "유저17", missionId: Mission.stub17.id)
    }
}

