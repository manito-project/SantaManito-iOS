//
//  EditUsernameView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import SwiftUI

struct EditUsernameView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: EditUsernameViewModel
    @Environment(\.dismiss) var dismiss
    
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
                        Text("산타 마니또가 나를\n뭐라고 부르는 게 좋을까?")
                            .font(.semibold_20)
                            .foregroundStyle(.smWhite)
                            .lineLimit(2)
                            .lineSpacing(4)
                        
                        Spacer()
                        
                        Image(.graphicsSantaNeck)
                    }
                }
                .padding(.horizontal, 16)
                
                // 네비게이션 바
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(.btnBack)
                        }
                        Spacer()
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.top, Device.topInset)
                    
                    Spacer()
                }
                
                
            }
            
        } content: {
            
            VStack {
                HStack {
                    Text("이름 수정")
                        .font(.semibold_20)
                        .foregroundStyle(.smBlack)
                    
                    Spacer()
                }
                .padding(.top, 34)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("내 이름 (최대 10자)")
                        .font(.semibold_16)
                        .foregroundStyle(.smDarkgray)
                        .padding(.top, 24)
                    
                    
                    TextField(
                        "",
                        text: $viewModel.username,
                        prompt: Text("마니또가 부를 비밀스러운 이름을 지어줘!")
                            .foregroundColor(.smLightgray)
                    )
                    .smTextFieldStyle()
                    .padding(.top, 12)
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.smLightgray, lineWidth: 1)
                )
                
                
                HStack {
                    
                    Spacer()
                    Button {
                        viewModel.send(.deleteAccountButtonDidTap)
                    } label: {
                        Text("회원탈퇴")
                            .font(.medium_16)
                            .foregroundStyle(.smLightgray)
                            .underline()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal)
                
                Spacer()
                
                Button("이름 수정 완료") {
                    viewModel.send(.doneButtonDidTap)
                }
                .smBottomButtonStyle()
                .disabled(viewModel.state.doneButtonDisabled)
                
                
            }.padding(.horizontal, 16)
            
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
        .loading(viewModel.state.isLoading)
        .smAlert(isPresented: viewModel.state.isDeleteAccountAlertPresented,
                 title: "탈퇴하면 소중한 추억이 담긴 마니또 내역을\n다시 확인할 수 없어. 그래도 괜찮아?",
                 primaryButton: ("탈퇴하기", {viewModel.send(.alertDeleteButtonDidTap)}),
                 secondaryButton: ("머무르기", { viewModel.send(.alertDismissDidTap)}))
        
        
    }
        
    
}

#Preview {
    EditUsernameView(viewModel: EditUsernameViewModel(userService: DIContainer.stub.service.userService, navigationRouter: DIContainer.stub.navigationRouter, windowRouter: DIContainer.stub.windowRouter))
        .environmentObject(DIContainer.stub)
}
