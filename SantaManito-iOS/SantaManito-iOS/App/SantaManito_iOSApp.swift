//
//  SantaManito_iOSApp.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import SwiftUI

@main
struct SantaManito_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container = DIContainer.default
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: .init(
                appService: container.service.appService,
                remoteConfigService: container.service.remoteConfigService,
                authService: container.service.authService)
            )
            .environmentObject(container)
            //TestView()
        }
    }
}
