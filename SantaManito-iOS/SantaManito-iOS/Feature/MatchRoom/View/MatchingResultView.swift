//
//  MatchingResultView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct MatchingResultView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: MatchingResultViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -40) {
                SMInfoView(
                    title: viewModel.state.roomName,
                    description: viewModel.state.description
                )
            } content: {
                VStack {
                    MatchingInfoView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 92)
                    
                    Button("마니또 하러 가기") {
                        viewModel.send(action: .goHomeButtonDidTap)
                    }.smBottomButtonStyle()
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

fileprivate struct MatchingInfoView: View {
    @ObservedObject private var viewModel: MatchingResultViewModel
    
    init(viewModel: MatchingResultViewModel) {
        self.viewModel = viewModel
    }
    
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
                
                Text("\(viewModel.state.me.username) 산타의 마니또는")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Spacer()
                    .frame(height: 16)
                
                HStack {
                    Spacer()
                    
                    Text(viewModel.state.mannito.username)
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
                
                Text("\(viewModel.state.me.username) 산타의 미션은")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Text(viewModel.state.mission) 
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, minHeight: 98, alignment: .top)
                    .background(.smLightbg)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                    .frame(height: 19)
                
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
    return MatchingResultView(
        viewModel: MatchingResultViewModel(
            roomService: DIContainer.stub.service.roomService,
            navigationRouter: DIContainer.stub.navigationRouter,
            roomInfo: .stub1
        )
    )
    .environmentObject(DIContainer.stub)
}
