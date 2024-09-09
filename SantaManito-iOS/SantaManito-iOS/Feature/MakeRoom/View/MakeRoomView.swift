//
//  MakeRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct MakeRoomView: View {
    
    @State var message: String
    @State private var time = Date()
    
    var body: some View {
        VStack {
            
            SMView(padding: -200) {
                
                HStack {
                    infoView
                    
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

                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 10)
                        
                        settingView
                    }
                    .frame(height: 448)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 25)
                    
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
                    
                    Spacer()
                }
            }
        }
    }
    
    
    var infoView: some View {
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
            
            Text("친구들이 방을 잘 찾아올 수 있도록\n방 이름과 종료일을 지정해보자!")
                .font(.semibold_16)
                .foregroundColor(.smWhite)
                .lineSpacing(3.5)
                .lineLimit(2)
            
            Spacer()
            
        }.padding(.leading, 16)
    }
    
    var settingView: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 30)
            
            Text("방 이름")
                .font(.semibold_20)
                .foregroundColor(.smDarkgray)
            
            TextField("이번 크리스마스에는 눈이 올까요?", text: $message)
                .font(.system(size: 16))
                .padding(.vertical, 11)
                .padding(.horizontal, 12)
                .background(.smLightgray)
                .cornerRadius(10)
            
            Spacer()
                .frame(height: 30)
            
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
            
            Spacer()
                .frame(height: 30)
            
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
            
        }.padding(.horizontal, 30)
    }
}


#Preview {
    MakeRoomView(message: "")
}
