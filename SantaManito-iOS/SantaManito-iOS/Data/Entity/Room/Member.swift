//
//  Member.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/11/24.
//

import Foundation

struct Member {
    var santa: User
    var manitto: User? 
}

extension Member {
    static var stub: [Member] {
        return [
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub1, manitto: .stub2)
        ]
    }
}
