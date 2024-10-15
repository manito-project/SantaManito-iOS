//
//  Mission.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation

public struct Mission: Identifiable, Hashable, Decodable {
    var content: String
    public var id = UUID() // TODO: 추후 서버로 부터 DTO어떻게 올지에 따라 달라짐
}

extension Mission {
    static var stub: Mission {
        .init(content: "손 잡기", id: UUID())
    }
    
    static func dummy() -> [Mission] {
        return [
            Mission(content: "손 잡기"),
            Mission(content: "손 잡기2"),
            Mission(content: "손 잡기3"),
            Mission(content: "손 잡기4"),
            Mission(content: "손 잡기5"),
            Mission(content: "손 잡기6"),
            Mission(content: "손 잡기7"),
            Mission(content: "손 잡기8"),
            Mission(content: "손 잡기"),
            Mission(content: "손 잡기"),
            Mission(content: "손 잡기")
        ]
    }
}
