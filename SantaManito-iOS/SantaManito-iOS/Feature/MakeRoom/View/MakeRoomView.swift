//
//  MakeRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct MakeRoomView: View {
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
}


#Preview {
    MakeRoomView()
}
