//
//  NavigationRoutingView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/21/24.
//

import Foundation
import SwiftUI

struct NavigationRoutingView: View {
  
  @EnvironmentObject var container: DIContainer
  @State var destination: NavigationDestination
  
    var body: some View {
        switch destination {
        case let .editRoom(viewType):
            EditRoomInfoView(
                viewModel: .init(
                    viewType: viewType,
                    roomService: container.service.editRoomService,
                    navigationRouter: container.navigationRouter
                ))
        case let .makeMission(roomInfo):
            EditMissionView(
                viewModel: EditMissionViewModel(
                    roomInfo: roomInfo,
                    navigationRouter: container.navigationRouter
                )
            )
        case let .roomInfo(roomInfo, missionList):
            CheckRoomInfoView(
                viewModel: .init(
                    roomInfo: roomInfo,
                    missionList: missionList,
                    roomService: container.service.editRoomService
                )
            )
            
        case .enterRoom:
            EnterRoomView(
                viewModel: .init(
                    roomService: container.service.enterRoomService,
                    navigationRouter: container.navigationRouter
                )
            )
        case .manitoWaitingRoom:
            ManitoWaitingRoomView(
                viewModel: .init(
                    enterRoomService: container.service.enterRoomService,
                    editRoomService: container.service.editRoomService, 
                    navigationRouter: container.navigationRouter
                )
            )

        case .myPage:
            MyPageView(viewModel: MyPageViewModel(navigationRouter: container.navigationRouter))
            
        case .editUsername:
            EditUsernameView(
                viewModel: EditUsernameViewModel(
                    userService: container.service.userService,
                    navigationRouter: container.navigationRouter
                )
            )
            Text("마이페이지")

        case .matchRoom:
            MatchingView(
                viewModel: MatchingViewModel(
                    roomService: container.service.matchRoomService,
                    navigationRouter: container.navigationRouter
                )
            )
        case .matchedRoom:
            MatchingResultView(
                viewModel: MatchingResultViewModel(
                    matchRoomService: container.service.matchRoomService,
                    editRoomService: container.service.editRoomService,
                    navigationRouter: container.navigationRouter
                )
            )
        }
    }
}


extension View {
    
    func setSMNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            return NavigationRoutingView(destination: destination)
        }
    }
    

}
