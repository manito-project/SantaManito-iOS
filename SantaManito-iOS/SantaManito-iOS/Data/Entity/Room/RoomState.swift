//
//  RoomState.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/23/24.
//

import Foundation

enum RoomState: Hashable, Comparable {
    
    // 순서대로
    case inProgress
    case notStarted
    case completed
    case expired
    case deleted
    
    
}
