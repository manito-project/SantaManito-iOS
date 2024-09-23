//
//  SMView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/7/24.
//

import SwiftUI

struct SMView<TopView: View, Content: View>: View {
    
    let topView: TopView
    let content: Content
    let padding: CGFloat
    
    init(
        padding: CGFloat = 0,
        @ViewBuilder topView: () -> TopView,
        @ViewBuilder content: () -> Content) {
            
        self.padding = padding
        self.topView = topView()
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.smNavy
                
                topView
            }
            .frame(height: 300)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            
            
            content
                .padding(.top, padding)
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        
    }
}

#Preview {
    SMView(topView: {
        Image(.snow)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
    }, content: {
        Text("산타마니또 SM View 프리뷰입니다.")
    })
}
