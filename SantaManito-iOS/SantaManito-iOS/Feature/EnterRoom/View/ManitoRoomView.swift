//
//  ManitoRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct ManitoRoomView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -100) {
                SMInfoView(
                    title: "마니또방이름최대1줄",
                    description: "오늘부터 7일 후인 12월 4일\n오전 10:00까지 진행되는 마니또"
                )
            } content: {
                
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.smLightgray, lineWidth: 1)
                            }
                        
                        ParticipateView()
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 360)
                    
                    Spacer()
                        .frame(height: 16)
                    
                    MatchingButtonView()
                    
                    Spacer()
                        .frame(height: 40)
                }
            }
            .onAppear {
                viewModel.send(action: .load)
            }
        }
    }
}

fileprivate struct MatchingButtonView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.state.description)
                .font(.medium_14)
                .foregroundColor(.smDarkgray)
                .padding(.top, 16)
                .padding(.leading, 16)
            
            Spacer()
                .frame(height: 40)
            
            if viewModel.state.isLeader {
                HStack {
                    Button {
                        viewModel.send(action: .editRoomInfo)
                    } label: {
                        Text("방 정보 수정하기")
                            .font(.semibold_16)
                            .foregroundColor(.smWhite)
                    }
                    .padding(.vertical, 17)
                    .padding(.horizontal, 28)
                    .background(.smDarkgray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                        .frame(width: 12)
                    
                    Button {
                        viewModel.send(action: .matchingButtonClicked)
                    } label: {
                        Text("바로 매칭 시작하기")
                            .font(.semibold_16)
                            .foregroundColor(.smWhite)
                    }
                    .padding(.vertical, 17)
                    .padding(.horizontal, 22)
                    .background(.smRed)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 16)
            } else {
                Button("마니또 랜덤 매칭하기") {
                    viewModel.send(action: .matchingButtonClicked)
                }
                .smBottomButtonStyle()
            }
        }
    }
    
}

fileprivate struct ParticipateView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack{
            TitleView()
            
            ParticipateListView()
        }
    }
}

fileprivate struct TitleView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 19)
            
            HStack {
                Text("참여자")
                    .font(.semibold_16)
                    .foregroundColor(.smDarkgray)
                    .padding(.leading, 16)
                    .padding(.trailing, 12)
                
                Button {
                    viewModel.send(action: .refreshParticipant)
                } label: {
                    Image(.icRefresh)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Button {
                    viewModel.send(action: .copyInviteCode)
                } label: {
                    Text("초대 코드 복사")
                        .font(.medium_14)
                        .foregroundColor(.smDarkgray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                }
                .background(.smLightgray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.trailing, 16)
            }
            .frame(height: 26)
            .background(.smWhite)
            
            Spacer()
                .frame(height: 19)
            
            Rectangle()
                .frame(width: .infinity, height: 1)
                .foregroundColor(.smLightgray)
            
            Spacer()
        }
    }
}

fileprivate struct ParticipateListView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 20)
            
            ScrollView(.vertical) {
                ForEach($viewModel.participantList) { $participantList in
                    ParticipateCellView(participate: $participantList)
                        .padding(.bottom, 16)
                }
            }
            .frame(height: 300)
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct ParticipateCellView: View {
    @Binding var participate: Participate
    var body: some View {
        HStack {
            Image(.graphicsRudolphCircle)
                .resizable()
                .frame(width: 36, height: 36)
                .padding(.leading, 16)
            
            Text(participate.name)
                .font(.medium_16)
                .foregroundColor(.smDarkgray)
            
            Spacer()
        }
        .frame(height: 36)
    }
}

#Preview {
    ManitoRoomView()
        .environmentObject(ManitoRoomViewModel())
}
