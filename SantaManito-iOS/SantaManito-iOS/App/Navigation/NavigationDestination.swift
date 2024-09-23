//
//  NavigationType.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/21/24.
//

import Foundation

enum NavigationDestination: Hashable {
    
    case editRoom(viewType: EditRoomViewType)
    case enterRoom
    case roomInfo(roomInfo: MakeRoomInfo, missionList: [Mission])
    case myPage
}
