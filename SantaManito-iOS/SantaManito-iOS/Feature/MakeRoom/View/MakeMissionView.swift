//
//  MakeMissionView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import SwiftUI

struct MakeMissionView: View {
    
    @StateObject var viewModel: MakeMissionViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -80) {
                HStack {
                    SMInfoView(
                        title: "미션 만들기", 
                        description: "어떤 미션이 괜찮을까\n천 번쯤 고민 중"
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
                    SettingMissionView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 34)
                    
                    MakeMissionButtonView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 74)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

fileprivate struct SettingMissionView: View {
    @ObservedObject private var viewModel: MakeMissionViewModel
    
    fileprivate init(viewModel: MakeMissionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.smLightgray, lineWidth: 1)
                }
            
            VStack(alignment: .center) {
                
                MissionListView(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 16)
                
                Button {
                    viewModel.send(action: .makeMissionButtonClicked)
                } label: {
                    HStack {
                        Text("마니또 미션 추가")
                            .font(.semibold_16)
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(width: 10)
                        
                        Image(.btnPlus)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 88)
                    .padding(.vertical, 12)
                    .background(.smDarkgray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .frame(height: 48)
                
                Spacer()
                
            }.padding(.horizontal, 16)
        }
        .frame(height: 402)
    }
}

private struct MissionListView: View {
    @ObservedObject private var viewModel: MakeMissionViewModel
    
    fileprivate init(viewModel: MakeMissionViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            
            ScrollView(.vertical) {
                
                ForEach(viewModel.missionList, id: \.self) { recordedFile in
                    MissionCellView(viewModel: viewModel)
                }
            }
        }
    }
}

private struct MissionCellView: View {
    @ObservedObject private var viewModel: MakeMissionViewModel
    
    fileprivate init(viewModel: MakeMissionViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var body: some View {
        ZStack {
            // 텍스트필드
            TextField(
                "",
                text: $viewModel.mission,
                prompt: Text("산타 할아버지 여기 미션 하나 추가요!")
                    .foregroundColor(.smLightgray)
            )
            .textFieldStyle(SMTextFieldStlyes())
            
            // Clear Button
            if !viewModel.mission.isEmpty {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        viewModel.send(action: .clearButtonClicked)
                    }) {
                        Image(.btnCancle)
                            .foregroundColor(.smDarkgray)
                            .padding(.trailing, 12)
                    }
                }
                .frame(height: 48)
            }
        }
        .onSubmit {
            print("Qyd")
        }
    }
}


fileprivate struct MakeMissionButtonView: View {
    @ObservedObject private var viewModel: MakeMissionViewModel
    
    fileprivate init(viewModel: MakeMissionViewModel) {
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
            .padding(.vertical, 17)
            .frame(width: 165)
            .background(.smRed) //state 추가하기
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}


#Preview {
    MakeMissionView(viewModel: MakeMissionViewModel())
}

