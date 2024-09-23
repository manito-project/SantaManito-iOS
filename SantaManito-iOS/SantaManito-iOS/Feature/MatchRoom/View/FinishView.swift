//
//  FinishView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct FinishView: View {
    @StateObject var viewModel: FinishViewModel
    
    var body: some View {
        ZStack {
            // 전체 화면에 배경색을 적용
            Color.smNavy
            
            // 콘텐츠를 VStack으로 구성
            VStack(alignment: .leading) {
                FinishTitleView(viewModel: viewModel)
                
                FinishResultView(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 28)
                
                Button("전체 결과 보기") {
                }.smBottomButtonStyle()
                
                Spacer()
                    .frame(height: 100)
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.send(action: .onAppear)
        }
    }
}

fileprivate struct FinishTitleView: View {
    @ObservedObject private var viewModel: FinishViewModel
    
    init(viewModel: FinishViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
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
                
                Text(viewModel.state.roomName)
                    .font(.semibold_18)
                    .foregroundColor(.smWhite)
                
                Spacer()
                    .frame(height: 16)
                
                Text(viewModel.state.description)
                    .font(.medium_16)
                    .foregroundColor(.smWhite)
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
        .frame(height: 224)
    }
}

fileprivate struct FinishResultView: View {
    @ObservedObject private var viewModel: FinishViewModel
    
    init(viewModel: FinishViewModel) {
        self.viewModel = viewModel
    }
    
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
                    
                    Text(viewModel.state.manito.manito)
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
                
                Text("\(viewModel.state.manito.manito) 산타의 미션은")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Text(viewModel.state.manito.mission)
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
    }
}

#Preview {
    FinishView(
        viewModel: FinishViewModel(
            matchRoomService: StubMatchRoomService(),
            editRoomService: StubEditRoomService()
        )
    )
}
