//
//  MatchingResultView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct MatchingResultView: View {
    var body: some View {
        VStack {
            SMView(padding: -100) {
                SMInfoView(
                    title: "마니또 방 이름 최대...",
                    description: "오늘부터 7일 후인 12월 4일\n오전 10:00까지 진행되는 마니또"
                )
            } content: {
                VStack {
                    MatchingInfoView()
                        .padding(.horizontal, 16)
                    
                    Spacer()
                        .frame(height: 92)
                    
                    Button("수정 완료") {
                    }.smBottomButtonStyle()
                    
                    Spacer()
                        .frame(height: 40)
                }
            }
        }
    }
}

fileprivate struct MatchingInfoView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.smLightgray, lineWidth: 1)
                }
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 24)
                
                Text("이영진 산타의 마니또는")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Spacer()
                    .frame(height: 16)
                
                HStack {
                    Spacer()
                    
                    Text("이한나")
                        .font(.semibold_24)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(.smNavy)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 30)
                
                Text("이영진 산타의 미션은")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Text("5천원 이하의 선물과 함께 카톡으로 수고했다고")
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                    .frame(height: 98, alignment: .top)
                    .background(.smLightbg)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                
                Spacer()
                
                HStack {
                    Image(.graphicsTree)
                        .resizable()
                        .frame(width: 54, height: 73)
                    
                    Spacer()
                    
                    Image(.graphicsTree)
                        .resizable()
                        .frame(width: 54, height: 73)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 360)
    }
}

#Preview {
    MatchingResultView()
}
