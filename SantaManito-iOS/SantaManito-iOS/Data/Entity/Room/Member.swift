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
    
    static var stub1: [Member] {
        return [
            Member(santa: .stub1, manitto: nil),
            Member(santa: .stub2, manitto: nil),
            Member(santa: .stub3, manitto: nil),
            
        ]
    }
    
    static var stub2: [Member] {
        return [
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub2, manitto: .stub3),
            Member(santa: .stub3, manitto: .stub4),
            Member(santa: .stub4, manitto: .stub1)
        ]
    }
    
    static var stub3: [Member] {
        return [
            Member(santa: .stub1, manitto: .stub2),
            Member(santa: .stub2, manitto: .stub1)
        ]
    }

}
