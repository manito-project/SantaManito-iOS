//
//  EnterRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct EnterRoomView: View {
    @StateObject var viewModel: EnterRoomViewModel
    @State var text: String
    
    var body: some View {
        VStack {
            SMView(padding: -70) {
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
                                .font(.semibold_20)
                                .foregroundColor(.smDarkgray)
                            
                            Spacer()
                            
                            TextField(
                                "",
                                text: $text, //viewModel. 초대코드
                                prompt: Text("코드를 입력하면 방에 들어갈 수 있어!")
                            ).smTextFieldStyle()
                            
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
                        
                        HStack {
                            Image(.icError)
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text("이미 참여중인 방이야!") //viewModel의 errMessag
                                .font(.medium_14)
                                .foregroundColor(.smRed)
                                .lineSpacing(3)
                                .lineLimit(2)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Button("입장하기") {
                        //초대코드에따라 적용
                    }
                    .smBottomButtonStyle()
                    
                    Spacer()
                        .frame(height: 40)
                }
               
            }
        }
    }
}

#Preview {
    EnterRoomView(viewModel: EnterRoomViewModel(), text: "")
}
