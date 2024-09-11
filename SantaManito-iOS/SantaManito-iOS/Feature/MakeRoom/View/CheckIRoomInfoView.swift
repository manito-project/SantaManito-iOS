//
//  CheckIRoomInfoView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct CheckIRoomInfoView: View {
    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -100) {
                SMInfoView(
                    title: "방 정보 확인",
                    description: "초대 전 상태 점검\n방 정보 췍~!"
                )
            } content: {
                VStack {
                    RoomInfoView()
                    
                    Spacer()
                    
                    Button("방 만들기") {
                        viewModel.send(action: .makeRoomButtonClicked)
                    }
                    .smBottomButtonStyle()
                    .padding(.top, 30)
                    
                    Spacer()
                        .frame(height: 40)
                }
            }
        }
        .smAlertWithInviteCode(
            isPresented: viewModel.state.isPresented,
            title: "초대 코드를 복사해서\n친구들에게 공유해 주자!",
            inviteCode: viewModel.inviteCode,
            primaryButton: ("초대 코드 복사", {
                viewModel.send(action: .copyInviteCode)
            })
        )
    }
}


fileprivate struct RoomInfoView: View {
    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DuedateInfoView()
            
            Spacer()
                .frame(height: 24)
            
            if !viewModel.missionList.isEmpty {
                MissionListView()
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
        .padding(.horizontal, 16)
    }
}
fileprivate struct DuedateInfoView: View {
    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 24)
            
            Text("마니또 방 이름 최대")
                .font(.semibold_16)
                .foregroundColor(.smDarkgray)
                .padding(.leading, 16)
            
            Spacer()
                .frame(height: 16)
            
            SMColoredTextView(
                fullText: "\(viewModel.remainingDays)일 후인 \(viewModel.state.dueDate)에 결과 공개!",
                coloredWord: viewModel.state.dueDate,
                color: .smRed
            )
            .font(.semibold_16)
            .foregroundColor(.smDarkgray)
            .padding(.leading, 16)
            
            Spacer()
                .frame(height: 24)
            
            Rectangle()
                .frame(width: .infinity, height: 1)
                .foregroundColor(.smLightgray)
        }
        .frame(height: 102)
        .onAppear {
            viewModel.send(action: .load)
        }
    }
}

private struct MissionListView: View {
    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
    
    //TODO: 여기 간격이 좀 이상한데 뭐 때문에 그런지 모르겠,,
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach($viewModel.missionList) { $mission in
                    MissionCellView(mission: $mission)
                        .padding(.bottom, 16)
                }
            }
            .frame(height: 300)
        }
        .padding(.horizontal, 16)
    }
}

private struct MissionCellView: View {
    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
    @Binding var mission: Mission
    
    fileprivate init(mission: Binding<Mission>) {
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
    CheckIRoomInfoView()
        .environmentObject(CheckIRoomInfoViewModel())
}
