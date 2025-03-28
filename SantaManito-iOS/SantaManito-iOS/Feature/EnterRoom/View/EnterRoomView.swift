//
//  EnterRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct EnterRoomView: View {
    @StateObject var viewModel: EnterRoomViewModel
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        
        SMView() {
            SMInfoView(
                title: "방 입장하기",
                description: "산타가 초대한 방으로\n마니또를 찾아 떠나볼까?"
            )
        } content: {
            VStack {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 40)
                    
                    Text("초대코드 입력")
                        .font(.semibold_20)
                        .foregroundColor(.smBlack)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 20)
                        
                        Text("초대코드")
                            .font(.semibold_16)
                            .foregroundColor(.smDarkgray)
                        
                        Spacer()
                        
                        TextField(
                            "",
                            text: $viewModel.inviteCode,
                            prompt: Text("코드를 입력하면 방에 들어갈 수 있어!")
                        )
                        .smTextFieldStyle()
                        .inputLimit($viewModel.inviteCode, maxLength: 20)
                        .submitLabel(.done)
                        
                        Spacer()
                            .frame(height: 24)
                    }
                    .padding(.horizontal, 16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.smLightgray, lineWidth: 1)
                    }
                    .frame(height: 132)
                    
                    Spacer()
                        .frame(height: 16)
                    
                    if viewModel.state.enterFailMessage.isPresented {
                        HStack {
                            Image(.icError)
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(viewModel.state.enterFailMessage.text)
                                .font(.medium_14)
                                .foregroundColor(.smRed)
                                .lineSpacing(3)
                                .lineLimit(2)
                        }
                    }
                }
                
                Spacer()
                
                Button("입장하기") {
                    viewModel.send(action: .enterButtonDidTap)
                }
                .disabled(!viewModel.state.enterButtonDisabled)
                .smBottomButtonStyle()
                
                Spacer()
                    .frame(height: 40)
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            viewModel.send(action: .onAppear)
        }
        
    }
    
    
}


#Preview {
    let container = DIContainer.stub
    return EnterRoomView(
        viewModel: EnterRoomViewModel(
            roomService: container.service.roomService,
            navigationRouter: container.navigationRouter
        )
    )
    .environmentObject(DIContainer.default)
}
