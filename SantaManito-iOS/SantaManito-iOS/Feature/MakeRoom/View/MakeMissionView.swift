//
//  MakeMissionView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import SwiftUI

struct MakeMissionView: View {
    @EnvironmentObject private var viewModel: MakeMissionViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -80) {
                SMInfoView(
                    title: "미션 만들기",
                    description: "어떤 미션이 괜찮을까\n천 번쯤 고민 중"
                )
            } content: {
                VStack {
                    SettingMissionView()
                    
                    Spacer()
                        .frame(height: 34)
                    
                    MakeMissionButtonView()
                    
                    Spacer()
                        .frame(height: 74)
                }
                .padding(.horizontal, 16)
            }
        }
        .smAlert(
            isPresented: viewModel.alertPresented,
            title: "아직 작성 중인 미션이 있어! \n미션이 사라져도 괜찮아?",
            primaryButton: ("나가기", {
                viewModel.send(action: .ignoreMissionButtonClicked)
            }),
            secondaryButton: ("미션 만들기", {
                viewModel.send(action: .dismissAlert)
            })
        )
    }
}

fileprivate struct SettingMissionView: View {
    @EnvironmentObject private var viewModel: MakeMissionViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.smLightgray, lineWidth: 1)
                }
            
            VStack(alignment: .center) {
                
                MissionListView()
                
                Spacer()
                    .frame(height: 16)
                
            }.padding(.horizontal, 16)
        }
        .frame(height: 402)
    }
}

private struct MissionListView: View {
    @EnvironmentObject private var viewModel: MakeMissionViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            
            ScrollView(.vertical) {
                ForEach($viewModel.missionList) { $mission in
                    MissionCellView(mission: $mission)
                }
                
                Spacer()
                    .frame(height: 16)
                
                Button {
                    viewModel.send(action: .addMission)
                } label: {
                    HStack {
                        Text("마니또 미션 추가")
                            .font(.semibold_16)
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(width: 10)
                        
                        //TODO: 플러스 버튼 피그마 에셋으로 교체하기
                        Image(.btnPlus)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                //TODO: 디테일 확인하면서 여기 크기 잡는 거. + 중앙 정렬 잘 되는지 다시 한번 확인
                .padding(.vertical, 16)
                .frame(width: 311, height: 48)
                .background(.smDarkgray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

private struct MissionCellView: View {
    @EnvironmentObject private var viewModel: MakeMissionViewModel
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
                viewModel.send(action: .editMission)
            }
            .textFieldStyle(SMTextFieldStlyes())
            
            //TODO: 마이너스 에셋 피그마 있는걸로 적용하기
            if viewModel.deleteButtonIsEnabled {
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
                .frame(height: 48)
            }
        }
    }
}

fileprivate struct MakeMissionButtonView: View {
    @EnvironmentObject private var viewModel: MakeMissionViewModel
    
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                viewModel.send(action: .skipMissionButtonClicked)
            } label: {
                Text("건너뛰기")
                    .font(.semibold_18)
                    .foregroundColor(.smWhite)
                
            }
            .padding(.vertical, 17)
            .frame(width: 165)
            .background(.smDarkgray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
                .frame(width: 12)
            
            Button {
                viewModel.send(action: .makeMissionButtonClicked)
            } label: {
                Text("미션 만들기 완료")
                    .font(.semibold_18)
                    .foregroundColor(.smWhite)
            }
            .disabled(!viewModel.makeMisstionButtonisEnabled)
            .padding(.vertical, 17)
            .frame(width: 165)
            .background(viewModel.makeMisstionButtonisEnabled ? .smRed : .smLightgray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    MakeMissionView()
        .environmentObject(MakeMissionViewModel())
}
