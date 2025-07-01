//
//  MyPageView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: MyPageViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(.btnBack)
                    }
                    Spacer()
                }
                
                Image(.logo)
                
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(.smNavy)
            .padding(.top, Device.topInset)
            
            
            VStack {
                ForEach(viewModel.state.items, id: \.self) { item in
                    Button {
                        viewModel.send(.cellDidTap(item))
                    } label: {
                        HStack {
                            Text(item.title)
                                .font(.medium_16)
                                .foregroundStyle(.smBlack)
                            
                            Spacer()
                            
                            Image(.btnFront)
                                .renderingMode(.template)
                                .tint(.smDarkgray)
                            
                        }
                        .frame(height: 60)
                        .padding(.horizontal, 16)
                    }
                    
                }
                
            }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(edges: .top)
        .setSMNavigation()
        .sheet(isPresented: $viewModel.state.isPresentedWebView.isPresented)  {
            SMWebView(url: viewModel.state.isPresentedWebView.url)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
       
        
        
    }
}
//
//#Preview {
//    MyPageView(viewModel: MyPageViewModel(navigationRouter: DIContainer.stub.navigationRouter))
//        .environmentObject(DIContainer.stub)
//}
