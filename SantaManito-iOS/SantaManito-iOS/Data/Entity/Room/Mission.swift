//
//  Mission.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation

public struct Mission: Identifiable, Hashable, Decodable {
    var content: String
    public var id: String = UUID().uuidString
}

extension Mission {
    static var stub1: Mission {
        .init(content: "손 잡기", id: UUID().uuidString)
//        .init(content: "손 잡기", id: "1")
    }
    
    static var stub2: Mission {
        .init(content: "손 잡기", id: UUID().uuidString)
//        .init(content: "손 잡기", id: "2")
    }
    
    static var stub3: Mission {
        .init(content: "손 잡기", id: UUID().uuidString)
//        .init(content: "손 잡기", id: "3")
    }
    
    static var stub4: Mission {
        .init(content: "손 잡기", id: UUID().uuidString)
//        .init(content: "손 잡기", id: "4")
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
