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
    var remainingDays: Int
    var dueDate: Date
    
    var expirationDate: Date {
        let day = createdAt.adjustDays(remainingDays).startOfDay
        let time = dueDate.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)
        return day.addingTimeInterval(time)
    }
}



