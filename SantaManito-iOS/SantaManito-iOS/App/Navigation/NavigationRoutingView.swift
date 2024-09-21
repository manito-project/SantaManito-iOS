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
            EditRoomInfoView(viewModel: .init(viewType: viewType))
        case .enterRoom:
            EnterRoomView(viewModel: .init())
        case .roomInfo:
            CheckRoomInfoView(viewModel: .init())
        case .myPage:
            Text("마이페이지")
        }
    }
}
