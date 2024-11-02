//
//  Member.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/11/24.
//

import Foundation

struct Member: Hashable {
    var santa: SantaUser
    var manitto: User? 
}

extension [Member] {
    
    static var stub_notStarted_4members: [Member] {
        return [
            Member(santa: .stub1, manitto: nil),
            Member(santa: .stub2, manitto: nil),
            Member(santa: .stub3, manitto: nil),
            Member(santa: .stub4, manitto: nil),
        ]
    }
    
    static var stub_matched_4members: [Member] {
        return [
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub2, manitto: .stub3),
            Member(santa: .stub3, manitto: .stub4),
            Member(santa: .stub4, manitto: .stub1)
        ]
    }
    
    static var stub_notStarted_17members: [Member] {
        return [
            Member(santa: .stub1, manitto: nil),
            Member(santa: .stub2, manitto: nil),
            Member(santa: .stub3, manitto: nil),
            Member(santa: .stub4, manitto: nil),
            Member(santa: .stub5, manitto: nil),
            Member(santa: .stub6, manitto: nil),
            Member(santa: .stub7, manitto: nil),
            Member(santa: .stub8, manitto: nil),
            Member(santa: .stub9, manitto: nil),
            Member(santa: .stub10, manitto: nil),
            Member(santa: .stub11, manitto: nil),
            Member(santa: .stub12, manitto: nil),
            Member(santa: .stub13, manitto: nil),
            Member(santa: .stub14, manitto: nil),
            Member(santa: .stub15, manitto: nil),
            Member(santa: .stub16, manitto: nil),
            Member(santa: .stub17, manitto: nil)
        ]
    }
    
    static var stub_matched_17members: [Member] {
        return [
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub2, manitto: .stub3),
            Member(santa: .stub3, manitto: .stub4),
            Member(santa: .stub4, manitto: .stub5),
            Member(santa: .stub5, manitto: .stub6),
            Member(santa: .stub6, manitto: .stub7),
            Member(santa: .stub7, manitto: .stub8),
            Member(santa: .stub8, manitto: .stub9),
            Member(santa: .stub9, manitto: .stub10),
            Member(santa: .stub10, manitto: .stub11),
            Member(santa: .stub11, manitto: .stub12),
            Member(santa: .stub12, manitto: .stub13),
            Member(santa: .stub13, manitto: .stub14),
            Member(santa: .stub14, manitto: .stub15),
            Member(santa: .stub15, manitto: .stub16),
            Member(santa: .stub16, manitto: .stub17),
            Member(santa: .stub17, manitto: .stub1)
        ]
    }
}
