//
//  MatchingView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct MatchingView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: MatchingViewModel
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Image(.splashBackground)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack{
                Spacer()
                    .frame(height: 200)
                
                Image(.graphicsRoulette)
                    .resizable()
                    .frame(width: 272, height: 272)
                    .rotationEffect(
                        Angle(degrees: rotation)
                    )
                    .animation(.linear(duration: 1.0).repeatForever(), value: viewModel.state.isAnimating)
                    .onAppear {
                        rotateContinuously()
                }
                
                Spacer()
                    .frame(height: 40)
                
                Text("잠시만 기다리면\n나만의 산타 마니또를 만날 수 있어!")
                    .font(.semibold_18)
                    .foregroundColor(.smWhite)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 70)
                
                Spacer()
            }
            
            
        }
        .onAppear(perform: {
            viewModel.send(action: .onAppear)
        })
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .smAlert(
            isPresented: viewModel.state.alert.isPresented,
            title: viewModel.state.alert.title,
            primaryButton: ("확인", {
                viewModel.send(action: .alert(.confirm))
            })
        )
        
        
    }
    
    func rotateContinuously() {
        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            rotation = 360 // 한 번 360도 회전
        }
    }
}

#Preview {
    let container = DIContainer.stub
    return MatchingView(
        viewModel: MatchingViewModel(
            roomService: container.service.roomService, 
            navigationRouter: container.navigationRouter,
            roomID: "roomID1"
        )
    )
    .environmentObject(DIContainer.default)
}
