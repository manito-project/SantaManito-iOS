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
            EditRoomInfoView(viewModel: .init(viewType: viewType, roomService: container.service.editRoomService))
        case .enterRoom:
            EnterRoomView(viewModel: .init(roomService: container.service.enterRoomService))
        case let .roomInfo(roomInfo, missionList):
            CheckRoomInfoView(viewModel: .init(roomInfo: roomInfo, missionList: missionList, roomService: container.service.editRoomService))
        case .myPage:
            MyPageView(viewModel: MyPageViewModel(navigationRouter: container.navigationRouter))
        case .editUsername:
            EditUsernameView()
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
