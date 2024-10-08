//
//  SMViewType.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/21/24.
//

import SwiftUI

protocol BaseView: View {
    
    associatedtype NavigationBar: View
    associatedtype TopView : View
    associatedtype Content : View
    
    var padding: CGFloat { get }
    
    @ViewBuilder var navigationBar: Self.NavigationBar { get }
    @ViewBuilder var topView: Self.TopView { get }
    @ViewBuilder var content: Self.Content { get}
}


extension BaseView {
    
    var padding: CGFloat { 0 }
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                Color.smNavy
                
                topView
                
                navigationBar
                    .padding(.top, Device.topInset)
                    .frame(maxWidth: .infinity)
                    .frame(height: Device.navigationBarHeight)
            }
            .frame(height: 300)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            
            
            content
                .padding(.top, 0)
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
    }
    
}
