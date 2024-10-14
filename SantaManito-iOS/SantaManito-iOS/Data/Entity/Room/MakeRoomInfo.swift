//
//  MakeRoomInfo.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/20/24.
//

import Foundation

public struct MakeRoomInfo: Hashable {
    var createdAt: Date = Date()
    var name: String
    var totalDurationDays: Int
    var dueDate: Date
    
    
    var expirationDate: Date {
        let day = createdAt.addingDays(totalDurationDays).startOfDay
        let time = dueDate.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)
        return day.addingTimeInterval(time)
    }
    
    var remainingDays: Int {
        return Date().daysBetweenInSeoulTimeZone(expirationDate)
    }
}

extension MakeRoomInfo {
    static var stub1: Self {
        .init(name: "방1", totalDurationDays: 5, dueDate: Date())
    }
}


