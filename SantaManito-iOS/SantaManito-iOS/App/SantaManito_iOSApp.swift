//
//  SantaManito_iOSApp.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import SwiftUI

@main
struct SantaManito_iOSApp: App {
    
    @StateObject var container = DIContainer(service: StubService())
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: .init(authService: container.service.authService))
                .environmentObject(container)
//            EnterRoomView(viewModel: EnterRoomViewModel())
        }
    }
}
