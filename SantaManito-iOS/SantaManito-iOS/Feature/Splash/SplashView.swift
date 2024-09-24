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
    SplashView(viewModel: SplashViewModel(authService: DIContainer(service: StubService()).service.authService))
        .environmentObject(DIContainer(service: StubService()))
}
