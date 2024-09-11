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
                HStack {
                    SMInfoView(
                        title: "방 정보 확인",
                        description: "초대 전 상태 점검\n방 정보 췍~!"
                    )
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(height: 80)
                        
                        Image(.graphicsSanta3)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 220)
                    }
                }
            } content: {
                VStack {
                    RoomInfoView()
                    
                    Spacer()
                    
                    Button("방 만들기") {
                        viewModel.send(action: .makeRoomButtonClicked)
                    }
                    .smBottomButtonStyle()
                    
                    Spacer()
                        .frame(height: 40)
                }
            }
        }
        .smAlertWithInviteCode(
            isPresented: viewModel.alertPresented,
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
                fullText: "\(viewModel.remainingDays)일 후인 \(viewModel.dueDate)에 결과 공개!",
                coloredWord: viewModel.dueDate,
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
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach($viewModel.missionList) { $mission in
                    MissionCellView(mission: $mission)
                    Spacer()
                        .frame(height: 16)
                }
            }
            .frame(height: 276)
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
            // 텍스트필드
            TextField(
                "",
                text: $mission.content,
                prompt: Text("산타 할아버지 여기 미션 하나 추가요!")
                    .foregroundColor(.smLightgray)
            )
            .onChange(of: mission.content) { newValue in
                
            }
            .textFieldStyle(SMTextFieldStlyes())
            
            //TODO: 마이너스 에셋 피그마 있는걸로 적용하기
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.send(action: .deleteMission(mission))
                }) {
                    Image(.btnCancle)
                        .foregroundColor(.smDarkgray)
                        .padding(.trailing, 12)
                }
            }
        }
        .frame(height: 48)
    }
}

#Preview {
    CheckIRoomInfoView()
        .environmentObject(CheckIRoomInfoViewModel())
}
