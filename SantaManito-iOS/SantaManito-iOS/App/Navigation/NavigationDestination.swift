//
//  NavigationType.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/21/24.
//

import Foundation

enum NavigationDestination: Hashable {
    
    case enterRoom
    
    case myPage
    
    //EditRoom
    case editRoom(viewType: EditRoomViewType)
    case makeMission(roomInfo: MakeRoomInfo)
    case roomInfo(roomInfo: MakeRoomInfo, missionList: [Mission])
}
