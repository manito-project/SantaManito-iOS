//
//  Mission.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation

struct Mission: Identifiable, Hashable {
    var content: String
    var id = UUID()
}

extension Mission {
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