//
//  Mission.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation

public struct Mission: Identifiable, Hashable, Decodable {
    var content: String
//    public var id = UUID() // TODO: 추후 서버로 부터 DTO어떻게 올지에 따라 달라짐
    public var id = String()
}

extension Mission {
    static var stub1: Mission {
        .init(content: "손 잡기 1", id: "mission_id_1")
    }

    static var stub2: Mission {
        .init(content: "손 잡기 2", id: "mission_id_2")
    }

    static var stub3: Mission {
        .init(content: "손 잡기 3", id: "mission_id_3")
    }

    static var stub4: Mission {
        .init(content: "손 잡기 4", id: "mission_id_4")
    }

    static var stub5: Mission {
        .init(content: "손 잡기 5", id: "mission_id_5")
    }

    static var stub6: Mission {
        .init(content: "손 잡기 6", id: "mission_id_6")
    }

    static var stub7: Mission {
        .init(content: "손 잡기 7", id: "mission_id_7")
    }

    static var stub8: Mission {
        .init(content: "손 잡기 8", id: "mission_id_8")
    }

    static var stub9: Mission {
        .init(content: "손 잡기 9", id: "mission_id_9")
    }

    static var stub10: Mission {
        .init(content: "손 잡기 10", id: "mission_id_10")
    }

    static var stub11: Mission {
        .init(content: "손 잡기 11", id: "mission_id_11")
    }

    static var stub12: Mission {
        .init(content: "손 잡기 12", id: "mission_id_12")
    }

    static var stub13: Mission {
        .init(content: "손 잡기 13", id: "mission_id_13")
    }

    static var stub14: Mission {
        .init(content: "손 잡기 14", id: "mission_id_14")
    }

    static var stub15: Mission {
        .init(content: "손 잡기 15", id: "mission_id_15")
    }

    static var stub16: Mission {
        .init(content: "손 잡기 16", id: "mission_id_16")
    }

    static var stub17: Mission {
        .init(content: "손 잡기 17", id: "mission_id_17")
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

extension [Mission] {
    static var stub_4mission: Self {
        [
            .init(content: "손 잡기 1", id: "mission_id_1"),
            .init(content: "손 잡기 2", id: "mission_id_2"),
            .init(content: "손 잡기 3", id: "mission_id_3"),
            .init(content: "손 잡기 4", id: "mission_id_4"),
        ]
    }
    
    static var stub_17mission: Self {
        [
            .init(content: "손 잡기 1", id: "mission_id_1"),
            .init(content: "손 잡기 2", id: "mission_id_2"),
            .init(content: "손 잡기 3", id: "mission_id_3"),
            .init(content: "손 잡기 4", id: "mission_id_4"),
            .init(content: "손 잡기 5", id: "mission_id_5"),
            .init(content: "손 잡기 6", id: "mission_id_6"),
            .init(content: "손 잡기 7", id: "mission_id_7"),
            .init(content: "손 잡기 8", id: "mission_id_8"),
            .init(content: "손 잡기 9", id: "mission_id_9"),
            .init(content: "손 잡기 10", id: "mission_id_10"),
            .init(content: "손 잡기 11", id: "mission_id_11"),
            .init(content: "손 잡기 12", id: "mission_id_12"),
            .init(content: "손 잡기 13", id: "mission_id_13"),
            .init(content: "손 잡기 14", id: "mission_id_14"),
            .init(content: "손 잡기 15", id: "mission_id_15"),
            .init(content: "손 잡기 16", id: "mission_id_16"),
            .init(content: "손 잡기 17", id: "mission_id_17")
        ]
    }
}
