//
//  NavigationType.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/21/24.
//

import Foundation

enum NavigationDestination: Hashable {
    
    //EnterRoom
    case enterRoom
    case manitoWaitingRoom
    
    case myPage
    case editUsername
    
    //EditRoom
    case editRoom(viewType: EditRoomViewType)
    case makeMission(roomInfo: MakeRoomInfo)
    case roomInfo(roomInfo: MakeRoomInfo, missionList: [Mission])
}
