//
//  OnboardingView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        SMView {
            ZStack {
                Image(.snow)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                
                VStack {
                    Spacer()
                    HStack {
                        Text(viewModel.state.step == .nickname 
                             ? "반가워, 이제부터\n산타 마니또에서 재미있게 놀자!"
                             : "필수약관에 동의하면 친구들과\n산타 마니또를 할 수 있어!")
                            .font(.semibold_20)
                            .foregroundStyle(.smWhite)
                            .lineLimit(2)
                            .lineSpacing(4)
                        
                        Spacer()
                            .frame(width: 22)
                        
                        Image(.graphicsSantaNeck)
                    }
                }
            }
            
        } content: {
            VStack {
                HStack {
                    Text(
                        viewModel.state.step == .nickname
                        ? "이름 설정"
                        : "필수 약관 동의"
                    )
                        .font(.semibold_20)
                        .foregroundStyle(.smBlack)
                    
                    Spacer()
                    
                    Text("1")
                        .foregroundStyle(.smWhite)
                        .font(.semibold_16)
                        .frame(width: 32, height: 32)
                        .background(
                            viewModel.state.step == .nickname
                            ? .smNavy
                            : .smLightgray
                        )
                        .clipShape(Circle())
                    
                    Spacer()
                        .frame(width: 12)
                    
                    Text("2")
                        .foregroundStyle(.smWhite)
                        .font(.semibold_16)
                        .frame(width: 32, height: 32)
                        .background(
                            viewModel.state.step == .agreement
                            ? .smNavy
                            : .smLightgray
                        )
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading) {
                    switch viewModel.state.step {
                    case .nickname:
                        nicknameView
                            .padding(.horizontal, 16)
                    case .agreement:
                        agreementView
                    }
                    
                    
                }
                .border(.smLightgray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                    
                Button(
                    viewModel.state.step == .nickname
                    ? "이름 짓기 완료"
                    : "산타마니또 시작하기"
                ) {
                    viewModel.send(.bottomButtonDidTap)
                }
                .smBottomButtonStyle()
                .disabled(viewModel.state.bottomButtonDisabled)
                
                
            }.padding(.horizontal, 16)
            
        }
        
    }
    
    @ViewBuilder
    var nicknameView: some View {
        Text("내 이름 (최대 10자)")
            .padding(.top, 24)
        
        TextField(
            "",
            text: $viewModel.nickname,
            prompt: Text("마니또가 부를 비밀스러운 이름을 지어줘!")
                .foregroundColor(.smLightgray)
        )
        .smTextFieldStyle()
        .padding(.top, 20)
        .padding(.bottom, 24)
    }
    
    var agreementView: some View {
        Color.white
    }
}

#Preview {
    OnboardingView(viewModel: .init(userService: DIContainer(service: StubService()).service.userService))
        
}
