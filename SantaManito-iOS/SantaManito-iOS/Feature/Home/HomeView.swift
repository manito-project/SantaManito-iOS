//
//  ContentView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            
            SMView(padding: -140) {
                
                ZStack {
                    Image(.snow)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 40)
                    
                    
                    VStack {
                        ZStack {
                            Image(.logo)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 36)
                            
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.send(.myPageButtonDidTap)
                                } label: {
                                    Image(.btnPerson)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        .frame(height: 44)
                        Spacer()
                    }
                    .padding(.top, 70)
                    .padding(.horizontal, 16)
                    
                }
            } content: {
                VStack {
                    HStack(spacing: 20) {
                        HomeButton(imageResource: .graphicsSantaNeck,
                                   title: "방 만들기",
                                   description: "새로운 산타\n 마니또 시작하기")
                        {
                            viewModel.send(.makeRoomButtonDidTap)
                        }
                        
                        HomeButton(imageResource: .graphicsRudolphNeck,
                                   title: "방 입장하기",
                                   description: "새로운 산타\n 입장코드 입력하기")
                        {
                            viewModel.send(.enterRoomButtonDidTap)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    HStack {
                        Text("나의 산타 마니또")
                            .font(.semibold_20)
                            .foregroundStyle(.smBlack)
                        Spacer()
                        Button {
                            viewModel.send(.refreshButtonDidTap)
                        } label: {
                            Image(.icRefresh)
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
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    
                    if viewModel.state.rooms.isEmpty {
                        roomsEmptyView
                    } else {
                        roomsView
                    }
                    
                    
                    Spacer()
                }
                
            }
            .onAppear {
                viewModel.send(.onAppear)
            }
            .smAlert(
                isPresented: viewModel.state.guestExitAlert.isPresented,
                title: viewModel.state.guestExitAlert.detail.name + "\n이 방을 나가는 거 맞지?",
                primaryButton: (
                    "방 나가기",
                    { 
                        viewModel.send(.dismissAlert)
                        viewModel.send(.guestExitButtonDidTap(roomDetail: viewModel.state.guestExitAlert.detail))}
                ),
                secondaryButton: ("방에 머물기", { viewModel.send(.dismissAlert) })
            )
            .smAlert(
                isPresented: viewModel.state.creatorExitAlert.isPresented,
                title: "방장이 나가면 재입장할 수 없고,\n친구들도 더 이상 방에 접속할 수 없어!",
                primaryButton: (
                    "방 나가기",
                    { 
                        viewModel.send(.dismissAlert)
                        viewModel.send(.creatorExitButtonDidTap(roomDetail: viewModel.state.creatorExitAlert.detail))}
                ),
                secondaryButton: ("방에 머물기", { viewModel.send(.dismissAlert) })
            )
        }
        
    }
    
    var roomsEmptyView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(.graphicsSnow)
            
            
            Text("친구들과 산타 마니또를 시작해 볼까?")
                .font(.medium_14)
                .foregroundStyle(.smDarkgray)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 240)
        .background(.smLightbg)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 16)
        .padding(.top, 20)
        
    }
    
    var roomsView: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.state.rooms, id: \.id) { room in
                        Button {
                            viewModel.send(.roomCellDidTap(roomDetail: room))
                        } label: {
                            HomeRoomCell(viewModel, room, width: proxy.size.width / 2.4)
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                        .simultaneousGesture(TapGesture().onEnded({})) // 부모의 터치 이벤트 막기
                        
                        
                        Spacer().frame(width: 15)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 20)
        
                
    }
    
}


fileprivate struct HomeButton : View {
    
    let imageResource: ImageResource
    let title: String
    let description: String
    let action: () -> Void
    
    fileprivate var body: some View {
        Button {
            action()
        } label: {
            
            VStack {
                Image(imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, -10)
                
                VStack(spacing: 10) {
                    
                    Text(title)
                        .font(.semibold_18)
                        .foregroundStyle(.smBlack)
                        .padding(.top, 30)
                    
                    Text(description)
                        .font(.medium_14)
                        .foregroundStyle(.smDarkgray)
                        .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .foregroundStyle(.black)
                .background(.white)
                .multilineTextAlignment(.center)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .shadow(radius: 2)
            }
        }
        .buttonStyle(ScaleButtonStyle())
        
    }
    
}

fileprivate struct HomeRoomCell: View {
    
    @ObservedObject var viewModel: HomeViewModel
    var roomInfo: RoomDetail
    let width: CGFloat
    
    fileprivate init(_ viewModel: HomeViewModel, _ roomInfo: RoomDetail, width: CGFloat) {
        self.roomInfo = roomInfo
        self.width = width
        self.viewModel = viewModel
       
    }
    
    fileprivate var body: some View {
        
        Group {
            VStack(alignment: .leading) {
                
                Text(roomInfo.name)
                    .font(.semibold_20)
                    .foregroundStyle(.smNavy)
                    .lineLimit(2)
                    .frame(height: 50)
                
                HStack { Spacer() }
                Spacer()
                
                if roomInfo.state == .completed || roomInfo.state == .inProgress {
                    Text(roomInfo.state == .notStarted
                         ? ""
                         : (roomInfo.me.manitto?.username ?? "-") + "의 산타")
                        .font(.medium_14)
                        .foregroundStyle(.smBlack)
                        .lineLimit(1)
                        .frame(height: 14)
                        .padding(.top, 22)
                    
                }
                
                if roomInfo.state != .deleted {
                    HomeRoomStateChip(state: roomInfo.state, remainingDays: roomInfo.remainingDays)
                        .padding(.top, 10)
                } else {
                    Text("방장에 의해 삭제되어 더는 참여할 수 없는 방이야")
                        .font(.medium_14)
                        .foregroundStyle(.smDarkgray)
                    Spacer()
                }
                
                
                Group { // 칩 하단
                    switch roomInfo.state {
                    case .inProgress, .completed:
                        Text(roomInfo.myMission?.content ?? "")
                            .font(.medium_14)
                            .foregroundStyle(.smDarkgray)
                            .lineLimit(2)
                            .padding(.top, 12)
                        
                    case .notStarted:
                        VStack {
                            Spacer()
                            Button {
                                viewModel.send(.exitButtonDidTap(roomDetail: roomInfo))
                            } label : {
                                Text("방 나가기")
                                    .font(.medium_14)
                                    .foregroundStyle(.smDarkgray)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 16)
                                    .background(.smLightbg)
                            }
                            .contentShape(Rectangle())
                        }
                    case .expired:
                        VStack {
                            Spacer()
                            Button {
                                viewModel.send(.exitButtonDidTap(roomDetail: roomInfo))
                            } label : {
                                Text("방 나가기")
                                    .font(.medium_14)
                                    .foregroundStyle(.smDarkgray)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.smDarkgray, lineWidth: 1)
                                    )
                            }
                            .contentShape(Rectangle())
                        }
                    case .deleted:
                        VStack {
                            Spacer()
                            Button {
                                viewModel.send(.deleteHistoryButtonDidTap(roomID: roomInfo.id))
                            } label : {
                                Text("삭제하기")
                                    .font(.medium_14)
                                    .foregroundStyle(.smDarkgray)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.smDarkgray, lineWidth: 1)
                                    )
                            }
                            .contentShape(Rectangle())
                        }
                    }
                }
                .frame(height: 60)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 12)
        }
        .frame(width: width)
        .frame(height: 240)
        .background(roomInfo.state == .deleted || roomInfo.state == .expired
                    ? .smLightbg
                    : .smWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.smLightgray, lineWidth: 1)
        )
        .padding(.vertical, 1)
        
        
        
    }
}

fileprivate struct HomeRoomStateChip: View {
    
    let state: RoomState
    let remainingDays: Int
    
    var title: String {
        switch state {
        case .notStarted:
            "매칭 대기 중"
        case .inProgress:
            "공개 \(remainingDays)일 전"
        case .completed:
            "결과 공개"
        case .expired:
            "기한 만료"
        case .deleted:
            "삭제"
        }
    }
    
    var backgroundColor: Color {
        switch state {
        case .notStarted:
            return .smDarkgray
        case .inProgress:
            return .smRed
        case .completed:
            return .smLightgray
        case .expired:
            return .smLightgray
        case .deleted:
            return .clear
        }
    }
    
    var body: some View {
        Text(title)
            .font(.medium_14)
            .foregroundStyle(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 16)
            .background(backgroundColor)
            .clipShape(.capsule)
    }
    
}


#Preview {
    HomeView(viewModel:
                HomeViewModel(roomService:
                                DIContainer.stub.service.roomService,
                              navigationRouter: DIContainer.stub.navigationRouter))
    .environmentObject(DIContainer.stub)
}
