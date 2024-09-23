//
//  MakeMissionView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import SwiftUI

struct EditMissionView: View {
    @StateObject var viewModel: EditMissionViewModel
    
    var body: some View {
        VStack {
            SMScrollView (padding: -50, topView: {
                SMInfoView(
                    title: "미션 만들기",
                    description: "어떤 미션이 괜찮을까\n천 번쯤 고민 중"
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
                        
                        MissionListView(viewModel: viewModel)
                            .padding(.horizontal, 16)
                    }
                    .frame(height: 402)
                    
                    Spacer()
                        .frame(height: 34)
                    
                    MakeMissionButtonView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 16)
            })
            .smAlert(
                isPresented: viewModel.state.isPresented,
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
}

fileprivate struct MissionListView: View {
    @ObservedObject private var viewModel: EditMissionViewModel
    
    fileprivate init(viewModel: EditMissionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            
            //TODO: 여기 간격이 좀 이상한데 뭐 때문에 그런지 모르겠,,
            ScrollView(.vertical, showsIndicators: false) {
                ForEach($viewModel.missionList) { $mission in
                    MissionCellView(viewModel: viewModel, mission: $mission)
                        .padding(.bottom, 16)
                }
                
                Button {
                    withAnimation(nil) {
                        viewModel.send(action: .addMission)
                    }
                } label: {
                    HStack {
                        Spacer()
                        
                        Text("마니또 미션 추가")
                            .font(.semibold_16)
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(width: 10)
                        
                        Image(.btnPlusLine)
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Spacer()
                    }
                }
                .frame(height: 48)
                .background(.smDarkgray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

private struct MissionCellView: View {
    @ObservedObject private var viewModel: EditMissionViewModel
    @Binding private var mission: Mission
    
    fileprivate init(
        viewModel: EditMissionViewModel,
        mission: Binding<Mission>
    ) {
        self.viewModel = viewModel
        self._mission = mission
    }

    fileprivate var body: some View {
        ZStack {
            TextField(
                "",
                text: $mission.content,
                prompt: Text("산타 할아버지 여기 미션 하나 추가요!")
                    .foregroundColor(.smLightgray)
            )
            .onChange(of: mission.content) { newValue in
                viewModel.send(action: .editMission)
            }.smTextFieldStyle()
            
            if viewModel.state.canDelete {
                HStack {
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
        }
        .frame(height: 48)
    }
}

fileprivate struct MakeMissionButtonView: View {
    @ObservedObject private var viewModel: EditMissionViewModel
    
    fileprivate init(viewModel: EditMissionViewModel) {
        self.viewModel = viewModel
    }
    
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
            .disabled(!viewModel.state.isEnabled)
            .padding(.vertical, 17)
            .frame(width: 165)
            .background(viewModel.state.isEnabled ? .smRed : .smLightgray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    EditMissionView(viewModel: EditMissionViewModel())
}
