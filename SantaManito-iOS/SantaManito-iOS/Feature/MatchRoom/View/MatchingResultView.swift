//
//  MatchingResultView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct MatchingResultView: View {
    @StateObject var viewModel: MatchingResultViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -100) {
                SMInfoView(
                    title: viewModel.state.room.name,
                    description: "오늘부터 \(viewModel.state.room.remainingDats)일 후인 \(viewModel.state.room.endData.toDueDateWithoutYear)\n\(viewModel.state.room.endData.toDueDateTime)까지 진행되는 마니또"
                )
            } content: {
                VStack {
                    MatchingInfoView(viewModel: viewModel)
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
                
                Text("\(viewModel.state.me) 산타의 마니또는") //TODO: 마니또
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Spacer()
                    .frame(height: 16)
                
                HStack {
                    Spacer()
                    
                    Text(viewModel.state.manito)
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
                
                Text("\(viewModel.state.me) 산타의 미션은")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Text(viewModel.state.mission)
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
    MatchingResultView(viewModel: MatchingResultViewModel())
}
