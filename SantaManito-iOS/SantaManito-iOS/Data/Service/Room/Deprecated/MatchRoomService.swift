//
//  MatchRoomService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/23/24.
//

import Foundation
import Combine

struct MatchingFinishData : Codable, Hashable {
    let userID, santaUserID, manittoUserID: Int
    let myMission, missionToMe: MissionToMe
    let santaUsername, manittoUsername: String

    enum CodingKeys: String, CodingKey {
        case userID = "UserId"
        case santaUserID = "SantaUserId"
        case manittoUserID = "ManittoUserId"
        case myMission = "MyMission"
        case missionToMe = "MissionToMe"
        case santaUsername = "SantaUsername"
        case manittoUsername = "ManittoUsername"
    }
}

// MARK: - MissionToMe
struct MissionToMe: Codable, Hashable {
    let content: String
}

extension MatchingFinishData {
    static var stub1: MatchingFinishData {
        .init(
            userID: 1,
            santaUserID: 2,
            manittoUserID: 1,
            myMission: MissionToMe(content: "5천원 이하의 선물과 함께 카톡으로 수고했다고 말하기 카톡으로 수고했다고 말하기"),
            missionToMe: MissionToMe(content: "5천원 이하의 선물과 함께 카톡으로 수고했다고 말하기 카톡으로 수고했다고 말하기"),
            santaUsername: "류희재",
            manittoUsername: "장석우"
        )
    }
    
    static var stub2: MatchingFinishData {
        .init(
            userID: 1,
            santaUserID: 2,
            manittoUserID: 1,
            myMission: MissionToMe(content: "뭐시기뭐시기뭐시기뭐시기"),
            missionToMe: MissionToMe(content: "뭐시기뭐시기뭐시기뭐시기"),
            santaUsername: "류희재",
            manittoUsername: "장석우"
        )
    }
    
    static var stub3: MatchingFinishData {
        .init(
            userID: 1,
            santaUserID: 2,
            manittoUserID: 1,
            myMission: MissionToMe(content: "뭐시기뭐시기뭐시기뭐시기"),
            missionToMe: MissionToMe(content: "뭐시기뭐시기뭐시기뭐시기"),
            santaUsername: "류희재",
            manittoUsername: "장석우"
        )
    }
    
    static var stub4: MatchingFinishData {
        .init(
            userID: 1,
            santaUserID: 2,
            manittoUserID: 1,
            myMission: MissionToMe(content: "5천원 이하의 선물과 함께 카톡으로 수고했다고 말하기"),
            missionToMe: MissionToMe(content: "5천원 이하의 선물과 함께 카톡으로 수고했다고 말하기"),
            santaUsername: "류희재",
            manittoUsername: "장석우"
        )
    }
    
    static var stubList: [MatchingFinishData] {
        return [.stub1, .stub2, .stub3, .stub4, .stub1, .stub2, .stub3, .stub4]
    }
}


//
//protocol MatchRoomServiceType {
//    func matchPlayer() -> AnyPublisher<Void, Error>
//    func getManito(_ userID: String) -> AnyPublisher<MatchingFinishData, Error>
//    func getManitoResult(_ roomID: String) -> AnyPublisher<[MatchingFinishData], Error>
//    func deleteRoom(_ roomID: String) -> AnyPublisher<Void, Error>
//}
//
//struct StubMatchRoomService: MatchRoomServiceType {
//    
//    func matchPlayer() -> AnyPublisher<Void, Error> {
//        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
//    }
//    
//    func getManito(_ userID: String) -> AnyPublisher<MatchingFinishData, Error> {
//        return Just(.stub1).setFailureType(to: Error.self).eraseToAnyPublisher()
//    }
//    
//    func getManitoResult(_ roomID: String) -> AnyPublisher<[MatchingFinishData], Error> {
//        return Just(MatchingFinishData.stubList).setFailureType(to: Error.self).eraseToAnyPublisher()
//    }
//    
//    func deleteRoom(_ roomID: String) -> AnyPublisher<Void, Error> {
//        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
//    }
//}
//
//
//
