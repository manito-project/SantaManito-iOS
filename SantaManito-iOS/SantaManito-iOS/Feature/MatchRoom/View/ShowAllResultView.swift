//
//  showAllResultView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/23/24.
//

//
//  FinishView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct ShowAllResultView: View {
    @StateObject var viewModel: ShowAllResultViewModel
    
    var body: some View {
        ZStack {
            // 전체 화면에 배경색을 적용
            Color.smNavy
            
            // 콘텐츠를 VStack으로 구성
            VStack(alignment: .leading) {
                ShowAllResultTitleView(viewModel: viewModel)
                
                ParticipateListView(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 28)
                
                Button("마니또 하러 가기") {
                    viewModel.send(action: .goHomeButtonClicked)
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

fileprivate struct ShowAllResultTitleView: View {
    @ObservedObject private var viewModel: ShowAllResultViewModel
    
    init(viewModel: ShowAllResultViewModel) {
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

fileprivate struct ParticipateListView: View {
    @ObservedObject private var viewModel: ShowAllResultViewModel
    
    init(viewModel: ShowAllResultViewModel) {
        self.viewModel = viewModel
    }
            
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 20)
                
                Text("총 16명")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                    .padding(.horizontal, 28)
                
                Spacer()
                    .frame(height: 16)
                
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundColor(.smLightgray)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.state.participateList, id: \.userID) { manitoResult in
                        ParticipateCellView(manitoResult: manitoResult)
                            .padding(.top, 15)
                    }
                }
                .padding(.horizontal, 28)
                Spacer()
                
            }
            .frame(height: 324)
            .background(.smWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

fileprivate struct ParticipateCellView: View {
    var manitoResult: MatchingFinishData
    
    init(manitoResult: MatchingFinishData) {
        self.manitoResult = manitoResult
    }
            
    var body: some View {
        HStack {
            Text(manitoResult.santaUsername)
                .font(.semibold_18)
                .foregroundColor(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 14)
                .multilineTextAlignment(.center)
                .background(.smNavy)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Spacer()
            
            Image(.arrow)
                .resizable()
                .frame(width: 30, height: 8)
            
            Spacer()
            
            Text(manitoResult.manittoUsername)
                .font(.semibold_18)
                .foregroundColor(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 14)
                .cornerRadius(30)
                .multilineTextAlignment(.center)
                .background(.smGreen)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .frame(height: 30)
    }
}

#Preview {
    ShowAllResultView(
        viewModel: ShowAllResultViewModel(
            matchRoomService: StubMatchRoomService(),
            editRoomService: StubEditRoomService()
        )
    )
}
