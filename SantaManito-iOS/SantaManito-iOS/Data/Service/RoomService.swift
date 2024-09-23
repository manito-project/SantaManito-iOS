//
//  RoomService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/16/24.
//
import Foundation
import Combine

struct RoomRequest { }

enum RoomState: Hashable {
    case notStarted
    case inProgress(deadline: Int)
    case completed
    case deleted
}

struct RoomInfo: Hashable {
    var id: String
    var name: String
    var state: RoomState
    var creatorName: String
    var mission: String
}

extension RoomInfo {
    static var stub1: RoomInfo {
        .init(
            id: "51e1c09f-19e6-4933-87d8-4deb35df6118---1",
            name: "마니또방이름 노출되는 곳입니당 최대",
            state: .notStarted,
            creatorName: "이한나",
            mission: "여기는 미션을 알려주는 공간입니다아 최대 2줄임"
        )
    }
    
    static var stub2: RoomInfo {
        .init(
            id: "51e1c09f-19e6-4933-87d8-4deb35df618---2",
            name: "마니또방이름 노출되는 곳입니당 최대 2줄입니다.",
            state: .inProgress(deadline: 3),
            creatorName: "장석우",
            mission: "여기는 미션을 알려주는 공간입니다아 최대 2줄임"
        )
    }
    
    static var stub3: RoomInfo {
        .init(
            id: "51e1c09f-19e6-4933-87d8-4deb35df61---3",
            name: "크리스마스요!",
            state: .completed,
            creatorName: "장석우",
            mission: "1임"
        )
    }
    
    static var stub4: RoomInfo {
        .init(
            id: "51e1c09f-19e6-4933-87d8-4deb35df61---4",
            name: "크리스마스",
            state: .deleted,
            creatorName: "류희재",
            mission: "메리메리메리메리크리스마스크리스마스크리스마스"
        )
    }
}

struct RoomDetailInfo { }


protocol RoomServiceType {
    func create(_ request: RoomRequest) -> AnyPublisher<String, Error>
    func fetch() -> AnyPublisher<[RoomInfo], Error>
    func fetch(with roomID: String) -> AnyPublisher<RoomDetailInfo, Error>
    func edit(with roomID: String) -> AnyPublisher<Void, Error>
    func delete(with roomID: String) -> AnyPublisher<Void, Error>
    
}

struct StubRoomService: RoomServiceType {
    func create(_ request: RoomRequest) -> AnyPublisher<String, Error> {
        Just("방식별자ID").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func fetch() -> AnyPublisher<[RoomInfo], Error> {
        Just([.stub1, .stub2, .stub3, .stub4]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func fetch(with roomID: String) -> AnyPublisher<RoomDetailInfo, Error> {
        Just(RoomDetailInfo()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func edit(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func delete(with roomID: String) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    
}
