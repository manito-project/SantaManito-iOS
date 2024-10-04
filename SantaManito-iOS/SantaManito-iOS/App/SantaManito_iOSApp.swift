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
    @StateObject var container = DIContainer.stub
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: .init(authService: container.service.authService, remoteConfigService: container.service.remoteConfigService))
                .environmentObject(container)
            //TestView()
        }
    }
}
