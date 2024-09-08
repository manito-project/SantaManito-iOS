//
//  DSKitDemoView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/8/24.
//

import SwiftUI



struct DSKitDemoView: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("SMBottomButton", destination: {smBottomButton})
                NavigationLink("SMView", destination: {smView})
                NavigationLink("SMViewWithPadding", destination: {smViewWithPadding})
                NavigationLink("SMScrollView", destination: {smScrollView})
                NavigationLink("SMAlertView", destination: {smAlertView})
            }
        }
        
    }
    
    //MARK: - smBottomButtonView
    
    @State var buttonDisabled = false
    var smBottomButton: some View {
        VStack {
            //MARK: Case 1
            Button("기본 바텀 버튼") {
                // Action
            }
            .smBottomButtonStyle()
            
            //MARK: Case 2
            Button("클릭시 비활성화 되는 버튼") {
                buttonDisabled = true
            }
            .disabled(buttonDisabled)
            .smBottomButtonStyle()
        }
    }
    
    //MARK: - smView
    var smView: some View {
        SMView {
            Image(.snow)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 40)
        } content: {
            Text("SMView 예시 입니다.")
        }
    }
    
    //MARK: - smPaddingView
    
    var smViewWithPadding: some View {
        SMView(padding: -200) {
            Image(.snow)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 40)
        } content: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                .frame(height: 200)
        }
    }
    
    //MARK: - smScrollView
    
    var smScrollView: some View {
        SMScrollView {
            // navy 영역에 들어갈 뷰
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(.graphicsSanta3)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
            }
        } content: {
            ForEach((0..<10), id: \.self) {
                Text("스크롤뷰 \($0) 예시입니다.")
                    .padding(.vertical, 20)
            }
        }
    }
    
   
    
    //MARK: - smAlertView
    @State var oneButtonAlertPresented: Bool = false
    @State var twoButtonAlertPresented: Bool = false
    var smAlertView: some View {
        VStack {
            //MARK: Case 1
            Button("버튼 한 개 alert 띄우기") {
                oneButtonAlertPresented = true
            }
            .padding(.vertical, 40)
            
            //MARK: Case 2
            Button("버튼 두 개 alert 띄우기") {
                twoButtonAlertPresented = true
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .smAlert(
            isPresented: oneButtonAlertPresented,
            title: "버튼 하나 짜리 alert입니다",
            primaryButton: ("확인", {
                // 액션 처리
                oneButtonAlertPresented = false
        }))
        .smAlert(
            isPresented: twoButtonAlertPresented,
            title: "버튼 하나 짜리 alert입니다",
            primaryButton: ("방 머물기", {
                // 액션 처리
                twoButtonAlertPresented = false
            }),
            secondaryButton: ("방 나가기", {
                // 액션 처리
                twoButtonAlertPresented = false
            })
        )
        
    }
    
}


#Preview {
    DSKitDemoView()
}
