//
//  ManitoRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct ManitoRoomView: View {
    @StateObject var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack {
            SMScrollView (padding: -50, topView: {
                SMInfoView(
                    title: "마니또방이름최대1줄",
                    description: "오늘부터 7일 후인 12월 4일\n오전 10:00까지 진행되는 마니또"
                )
            }, content: {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.smLightgray, lineWidth: 1)
                            }
                        
                        VStack{
                            TitleView(viewModel: viewModel)
                            
                            ParticipateListView(viewModel: viewModel)
                        }
                    }
                    .frame(height: 360)
                    
                    Spacer()
                        .frame(height: 16)
                    
                    MatchingButtonView(viewModel: viewModel)
                    
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 16)
            })
            .onAppear {
                viewModel.send(action: .load)
            }
            
        }
    }
}

fileprivate struct TitleView: View {
    @ObservedObject private var viewModel: ManitoRoomViewModel
    
    fileprivate init(viewModel: ManitoRoomViewModel) {
        self.viewModel = viewModel
    }
    
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
    @ObservedObject private var viewModel: ManitoRoomViewModel
    
    fileprivate init(viewModel: ManitoRoomViewModel) {
        self.viewModel = viewModel
    }
    
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

fileprivate struct MatchingButtonView: View {
    @ObservedObject private var viewModel: ManitoRoomViewModel
    
    fileprivate init(viewModel: ManitoRoomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.state.description)
                .font(.medium_14)
                .foregroundColor(.smDarkgray)
                .padding(.top, 16)
            
            Spacer()
                .frame(height: 40)
            
            if viewModel.state.isLeader {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.send(action: .editRoomInfo)
                    } label: {
                        HStack {
                            Spacer()
                            Text("방 정보 수정하기")
                                .font(.semibold_16)
                                .foregroundColor(.smWhite)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 17)
                    .background(.smDarkgray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                        .frame(width: 12)
                    
                    Button {
                        viewModel.send(action: .matchingButtonClicked)
                    } label: {
                        HStack {
                            Spacer()
                            Text("바로 매칭 시작하기")
                                .font(.semibold_16)
                                .foregroundColor(.smWhite)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 17)
                    .background(.smRed)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                }
            } else {
                Button("마니또 랜덤 매칭하기") {
                    viewModel.send(action: .matchingButtonClicked)
                }
                .smBottomButtonStyle()
            }
        }
    }
}

#Preview {
    ManitoRoomView(viewModel: ManitoRoomViewModel())
}