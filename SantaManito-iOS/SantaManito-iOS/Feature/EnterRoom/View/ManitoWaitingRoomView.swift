//
//  ManitoRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct ManitoWaitingRoomView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: ManitoWaitingRoomViewModel
    
    var body: some View {
        VStack {
            SMScrollView (padding: -50, topView: {
                SMInfoView(
                    title: viewModel.state.roomDetail.name,
                    description: "오늘부터 \(viewModel.state.roomDetail.remainingDays)일 후인 \(viewModel.state.roomDetail.expirationDate.toDueDateWithoutYear)\n\(viewModel.state.roomDetail.expirationDate.toDueDateTime)까지 진행되는 마니또"
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
                viewModel.send(action: .onAppear)
            }
            
        }
    }
}

fileprivate struct TitleView: View {
    @ObservedObject private var viewModel: ManitoWaitingRoomViewModel
    
    fileprivate init(viewModel: ManitoWaitingRoomViewModel) {
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
                    viewModel.send(action: .refreshButtonDidTap)
                } label: {
                    Image(.icRefresh)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .rotationEffect(
                            Angle(
                                degrees:  viewModel.state.isLoading ? 360 : 0
                            )
                        )
                        .animation(
                            viewModel.state.isLoading
                            ? .linear(duration: 1).repeatForever(autoreverses: false)
                            : .default,
                            value: viewModel.state.isLoading
                        )
                }
                .disabled(viewModel.state.isLoading)
                
                Spacer()
                
                Button {
                    viewModel.send(action: .copyInviteCodeDidTap)
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
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .foregroundColor(.smLightgray)
            
            Spacer()
        }
    }
}

fileprivate struct ParticipateListView: View {
    @ObservedObject private var viewModel: ManitoWaitingRoomViewModel
    
    fileprivate init(viewModel: ManitoWaitingRoomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 20)
            
            ScrollView(.vertical) {
                ForEach(viewModel.state.roomDetail.members, id: \.self) { member in
                    ParticipateCellView(user: member.santa)
                        .padding(.bottom, 16)
                }
            }
            .frame(height: 300)
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct ParticipateCellView: View {
    var user: SantaUser
    private let imageNames: [ImageResource] = [.graphicsRudolphCircle, .graphicsSnowCircle, .graphicsSantaCircle]
    var body: some View {
        HStack {
            Image(imageNames.randomElement()!)
                .resizable()
                .frame(width: 36, height: 36)
                .padding(.leading, 16)
            
            Text(user.username)
                .font(.medium_16)
                .foregroundColor(.smDarkgray)
            
            Spacer()
        }
        .frame(height: 36)
    }
}

fileprivate struct MatchingButtonView: View {
    @ObservedObject private var viewModel: ManitoWaitingRoomViewModel
    
    fileprivate init(viewModel: ManitoWaitingRoomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.state.roomDetail.isHost
                 ? "방장 산타는 참여자가 다 모이면 마니또 매칭을 해줘!"
                 : "방장 산타가 마니또 매칭을 할 때까지 기다려보자!"
            )
                .font(.medium_14)
                .foregroundColor(.smDarkgray)
                .padding(.top, 16)
            
            Spacer()
                .frame(height: 40)
            
            if viewModel.state.roomDetail.isHost {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.send(action: .editButtonDidTap)
                    } label: {
                        HStack {
                            Spacer()
                            Text("수정하기")
                                .font(.semibold_16)
                                .foregroundColor(.smWhite)
                            Spacer()
                        }
                    }
                    .smBottomButtonStyle(.darkgray)
                    .disabled(!viewModel.state.roomDetail.isHost)
                    
                    
                    
                    Spacer()
                        .frame(width: 12)
                    
                    Button {
                        viewModel.send(action: .matchingButtonDidTap)
                    } label: {
                        HStack {
                            Spacer()
                            Text("바로 매칭 시작하기")
                                .font(.semibold_16)
                                .foregroundColor(.smWhite)
                            Spacer()
                        }
                    }
                    .smBottomButtonStyle()
                    .disabled(viewModel.state.roomDetail.members.count < 2)
                    .disabled(!viewModel.state.roomDetail.isHost)
                    
                    Spacer()
                }
            } else {
                Button("바로 매칭 시작하기") {
                    viewModel.send(action: .matchingButtonDidTap)
                }
                .disabled(true)
                .smBottomButtonStyle()
            }
        }
    }
}

#Preview {
    let container = DIContainer.stub
    return ManitoWaitingRoomView(
        viewModel: ManitoWaitingRoomViewModel(
            roomService: container.service.roomService,
            navigationRouter: container.navigationRouter,
            roomDetail: .stub1
        )
    )
    .environmentObject(DIContainer.default)
}
