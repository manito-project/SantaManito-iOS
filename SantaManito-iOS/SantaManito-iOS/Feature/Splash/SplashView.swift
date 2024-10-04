//
//  SplashView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        
        Group {
            switch viewModel.state.desination {
            case .splash: splashView
            case .onboarding: OnboardingView(
                viewModel: .init(userService: container.service.userService, signUpCompleted: {
                    viewModel.state.desination = .main
                })
            )
            case .main:
                HomeView(
                viewModel: .init(
                    roomService: container.service.roomService,
                    navigationRouter: container.navigationRouter
                )
            )
            }
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
        .smAlert(
            isPresented:
                viewModel.state.serverCheckAlert.isPresented,
            title: viewModel.state.serverCheckAlert.message,
            primaryButton: ("확인 후 앱 닫기", {
                exit(0)
            }))
            
    }
        
    
    var splashView: some View {
        ZStack {
            Image(.splashBackground)
                .resizable()
                .scaledToFill()
            
            VStack(alignment: .center) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 140)
                    .padding(.horizontal, 106)
                
                
                Spacer()
                Image(.graphics3Friends)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 47)
                
                Color.smWhite
                    .frame(height: 120)
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel(appService: DIContainer.stub.service.appService, remoteConfigService: DIContainer.stub.service.remoteConfigService, authService: DIContainer.stub.service.authService))
        .environmentObject(DIContainer.stub)
}
