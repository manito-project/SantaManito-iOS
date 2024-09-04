//
//  ContentView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        VStack {
            
            Color.blue
                .ignoresSafeArea()
                .frame(height: 200)
            
            HStack(spacing: 20) {
                HomeButton(imageResource: .iconSantaNeck,
                           title: "방 만들기",
                           description: "새로운 산타\n 마니또 시작하기")
                {
                    
                }
                
                HomeButton(imageResource: .iconRudolphNeck,
                           title: "방 입장하기",
                           description: "새로운 산타\n 입장코드 입력하기")
                {
                    
                }
            }
            .padding(.top, -150)
            .padding(.horizontal, 40)
            
            HStack {
                Text("나의 산타 마니또")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(.gray)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
            
            
            Spacer()
        }
        
        
    }
}


fileprivate struct HomeButton : View {
    
    let imageResource: ImageResource
    let title: String
    let description: String
    let action: () -> Void
    
    fileprivate var body: some View {
        Button {
            action()
        } label: {
            
            VStack {
                Image(imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, -10)
                
                VStack(spacing: 10) {
                    
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top, 30)
                    
                    Text(description)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .shadow(radius: 2)
            }
        }
        .buttonStyle(ScaleButtonStyle())
        
    }

}


#Preview {
    HomeView()
}
