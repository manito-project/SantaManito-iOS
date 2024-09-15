//
//  FinishView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct FinishView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            FinishTitleView()
            
            FinishResultView()
            
            Spacer()
                .frame(height: 28)
            
            FinishButtonView()
            
            Spacer()
                .frame(height: 40)
        }
        .ignoresSafeArea()
        .background(.smNavy)
    }
}

fileprivate struct FinishTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Button {
                } label: {
                    Image(.btnBack)
                        .resizable()
                        .frame(width: 12, height: 20)
                }
                .padding(.top, 50)
                
                Spacer()
                    .frame(height: 50)
                
                Text("마니또 방 이름")
                    .font(.semibold_18)
                    .foregroundColor(.smWhite)
                
                Spacer()
                    .frame(height: 16)
                
                Text("7일동안의 산타 마니또 종료!\n나의 산타 마니또는 누구일까?")
                    .font(.medium_16)
                    .foregroundColor(.smWhite)
                
                
                Spacer()
            }
            
            Spacer()
                .frame(width: 20)
            
            VStack {
                HStack(alignment: .top) {
                    Image(.graphicsSocks1)
                        .resizable()
                        .frame(width: 30, height: 108)
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Image(.graphicsSocks2)
                        .resizable()
                        .frame(width: 40, height: 141)
                }
                
                Spacer()
                    .frame(height: 26)
                
                Image(.graphics3Friends)
                    .resizable()
                    .frame(width: 120, height: 57)
                
                Spacer()
                
            }
        }

        .padding(.horizontal, 16)
    }
}

fileprivate struct FinishResultView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 20)
                
                Text("나를 챙겨준 사람") //TODO: 마니또
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                    .lineSpacing(2)
                
                Spacer()
                    .frame(height: 30)
                
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
                
                Text("미션최대삼십육자야그럼한줄에열두자만가능함더이상은안되지롱메롱바보똥개멍")
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 61)
                    .padding(.vertical, 11)
                    .frame(height: 98, alignment: .top)
                    .background(.smLightbg)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                    .frame(height: 20)
            }
            .padding(.horizontal, 28)
            
            .frame(height: 324)
            .background(.smWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct FinishButtonView: View {
    var body: some View {
        VStack {
            Button("전체 결과 보기") {
                
            }.smBottomButtonStyle()
            
            Spacer()
                .frame(height: 16)
            
            Button("나의 산타 마니또에서 삭제하기") {
                
            }.smBottomButtonStyle()
        }
    }
}

#Preview {
    FinishView()
}
