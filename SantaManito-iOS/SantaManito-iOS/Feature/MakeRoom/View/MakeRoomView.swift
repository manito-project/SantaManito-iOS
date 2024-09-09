//
//  MakeRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 44)
            
            Button(action: {
            }, label: {
                Image(.btnBack)
            })
            
            Spacer()
                .frame(height: 47)
            
            Text("방 정보 설정")
                .font(.semibold_20)
                .foregroundColor(.smWhite)
            
            Spacer()
                .frame(height: 16)
            
            Text("언제까지 마니또 게임하게 할거야 \n내 마니또를 봐 산타 기다리잖아")
                .font(.medium_16)
                .foregroundColor(.smWhite)
                .lineSpacing(3.5)
                .lineLimit(2)
            
            Spacer()
            
        }.padding(.leading, 16)
    }
}

struct SettingRoomInfoView: View {
    @State var message: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 30)
                
                setRoomNameView
                
                Spacer()
                    .frame(height: 30)
                
                setEndDateView
                
                Spacer()
                    .frame(height: 30)
                
                setEndTimeView
                
            }.padding(.horizontal, 30)
        }
        .frame(height: 448)
        .padding(.horizontal, 20)
    }
    
    var setRoomNameView: some View {
        VStack(alignment: .leading) {
            Text("방이름 (최대 17자)")
                .font(.semibold_16)
                .foregroundColor(.smDarkgray)
            
            Spacer()
                .frame(height: 12)
            
            TextField(
                "",
                text: $message,
                prompt: Text("재미있는 방 이름을 지어보자!").foregroundColor(.smLightgray)
            )
            .font(.medium_16)
            .foregroundColor(.smDarkgray)
            .padding(.vertical, 16)
            .padding(.leading, 12)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.smLightgray, lineWidth: 1)
            }
        }
    }
    
    var setEndDateView: some View {
        VStack(alignment: .leading) {
            Text("마니또 산타 공개일 설정")
                .font(.semibold_20)
                .foregroundColor(.smDarkgray)
            
            Spacer()
                .frame(height: 16)
            
            HStack {
                Button(action: {}, label: {
                    Image(.btnMinus)
                        .resizable()
                        .frame(width: 25, height: 25)
                })
                
                Spacer()
                    .frame(width: 16)
                
                Text("7일 후")
                
                Spacer()
                    .frame(width: 16)
                
                Button(action: {}, label: {
                    Image(.btnPlus)
                        .resizable()
                        .frame(width: 25, height: 25)
                })
                
            }.background(content: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.smLightgray)
                    .frame(width: 150, height: 40)
            })
            .frame(width: 150, height: 40)
            
            Spacer()
                .frame(height: 10)
            
            Text("최소 3일 부터 최대 14일까지 기간을 설정할 수 있어~")
                .font(.medium_14)
                .foregroundColor(.smDarkgray)
        }
    }
    
    var setEndTimeView: some View {
        VStack(alignment: .leading) {
            Text("마니또 산타 공개 시간")
                .font(.semibold_20)
                .foregroundColor(.smDarkgray)
            
            Spacer()
                .frame(height: 16)
            
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
                .background(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.smLightgray)
                        .frame(width: 79, height: 40)
                })
                .frame(width: 79, height: 40)
                
                //TODO: configuration을 통해서 커스텀 토클 만들기
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
                .background(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.smLightgray)
                        .frame(width: 112, height: 40)
                })
                .frame(width: 112, height: 40)
            }
            
            Spacer()
                .frame(height: 30)
            
            Text("7일 후인 2020/12/04 오전 10: 00에\n산타 마니또 결과가 공개될거야!")
                .font(.medium_14)
                .foregroundStyle(.smDarkgray)
                .lineLimit(2)
        }
    }
    
    
}

struct MakeRoomView: View {
    
    
    @State private var time = Date()
    
    var body: some View {
        VStack {
            
            SMView(padding: -200) {
                
                HStack {
                    InfoView()
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(height: 49)
                        
                        Image(.graphicsSanta3)
                            .resizable()
                            .frame(width: 130, height: 250)
                    }
                }
            } content: {
                VStack {
                    Spacer()
                        .frame(height: 100)
                    
                    SettingRoomInfoView(message: "")
                    
                    Spacer()
                        .frame(height: 25)
                    
                    VStack{
                        Button("미션 만들기") {
                            // Action
                        }
                        .smBottomButtonStyle()
                        
                        Spacer()
                            .frame(height: 10)
                        
                        Button("미션 만들기") {
                            // Action
                        }
                        .smBottomButtonStyle()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    MakeRoomView()
}
