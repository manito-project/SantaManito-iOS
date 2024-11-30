//
//  CheckIRoomInfoView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct CheckRoomInfoView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: CheckRoomInfoViewModel
    
    var body: some View {
        
        SMScrollView (padding: -50, topView: {
            SMInfoView(
                title: "방 정보 확인",
                description: "초대 전 상태 점검\n방 정보 췍~!"
            )
        }, content: {
            VStack {
                RoomInfoView(viewModel: viewModel)
                
                Spacer()
                
                Button("방 만들기") {
                    viewModel.send(action: .makeRoomButtonDidTap)
                }
                .smBottomButtonStyle()
                .padding(.top, 30)
                
                Spacer()
                    .frame(height: 40)
            }
            .padding(.horizontal, 16)
        })
        .loading(viewModel.state.isLoading)
        .smAlertWithInviteCode(
            isPresented: viewModel.state.isPresented,
            title: "초대 코드를 복사해서\n친구들에게 공유해 주자!",
            inviteCode: viewModel.inviteCode ?? "몰루?",
            primaryButton: ("초대 코드 복사", {
                viewModel.send(action: .copyInviteCode)
            })
        ) //TODO: 몰루 변경 ㅋㅋ 뻘하게 웃기네
    }
    
}


fileprivate struct RoomInfoView: View {
    @ObservedObject private var viewModel: CheckRoomInfoViewModel
    
    fileprivate init(viewModel: CheckRoomInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DuedateInfoView(viewModel: viewModel)
            
            Spacer()
                .frame(height: 24)
            
            if !viewModel.missionList.isEmpty {
                MissionListView(viewModel: viewModel)
            } else {
                VStack {
                    Text("이번에는 마니또만 매칭될거야!\n다음에는 재미있는 미션을 추가해줘!")
                        .lineLimit(2)
                        .lineSpacing(3)
                        .font(.medium_14)
                        .foregroundColor(.smDarkgray)
                        .padding(.leading, 16)
                    
                    Spacer()
                        .frame(height: 24)
                }
                .frame(height: 64)
            }
        }
        .background(.smWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.smLightgray, lineWidth: 1)
        }
    }
}
fileprivate struct DuedateInfoView: View {
    @ObservedObject private var viewModel: CheckRoomInfoViewModel
    
    fileprivate init(viewModel: CheckRoomInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 24)
            
            Text("\(viewModel.roomInfo.name)")
                .font(.semibold_16)
                .foregroundColor(.smDarkgray)
                .padding(.leading, 16)
            
            Spacer()
                .frame(height: 16)
            
            //TODO: 기기에 따라서 레이아웃이 어색함
            SMColoredTextView(
                fullText: "\(viewModel.roomInfo.remainingDays)일 후인 \(viewModel.roomInfo.expirationDate.toDueDateAndTime)에 결과 공개!",
                coloredWord: viewModel.roomInfo.expirationDate.toDueDateAndTime,
                color: .smRed
            )
            .font(.semibold_16)
            .foregroundColor(.smDarkgray)
            .padding(.leading, 16)
            
            Spacer()
                .frame(height: 24)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .foregroundColor(.smLightgray)
        }
        .frame(height: 102)
    }
}

private struct MissionListView: View {
    @ObservedObject private var viewModel: CheckRoomInfoViewModel
    
    fileprivate init(viewModel: CheckRoomInfoViewModel) {
        self.viewModel = viewModel
    }
    
    //TODO: 여기 간격이 좀 이상한데 뭐 때문에 그런지 모르겠,,
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach($viewModel.missionList) { $mission in
                    MissionCellView(
                        viewModel: viewModel,
                        mission: $mission
                    )
                    .padding(.bottom, 16)
                }
            }
            .frame(height: 300)
        }
        .padding(.horizontal, 16)
    }
}

private struct MissionCellView: View {
    @ObservedObject private var viewModel: CheckRoomInfoViewModel
    @Binding var mission: Mission
    
    fileprivate init(
        viewModel: CheckRoomInfoViewModel,
        mission: Binding<Mission>
    ) {
        self.viewModel = viewModel
        self._mission = mission
    }
    
    fileprivate var body: some View {
        ZStack {
            HStack {
                Text(mission.content)
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                    .padding(.leading, 12)
                    .padding(.vertical, 16)
                
                Spacer()
                
                Button(action: {
                    viewModel.send(action: .deleteMission(mission))
                }) {
                    Image(.btnDelete)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                }
            }
        }
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.smLightgray, lineWidth: 1)
        }
    }
}

#Preview {
    let container = DIContainer.stub
    return CheckRoomInfoView(
        viewModel: CheckRoomInfoViewModel(
            roomInfo: .stub1,
            missionList: Mission.dummy(),
            roomService: DIContainer.stub.service.roomService,
            navigationRouter: DIContainer.stub.navigationRouter
        )
    )
    .environmentObject(DIContainer.default)
}
