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
            SMView(padding: -100) {
                HStack {
                    SMInfoView(
                        title: "미션 만들기", description: "어떤 미션이 괜찮을까\n천 번쯤 고민 중")
                    
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
                    
                    
                    Spacer()
                        .frame(height: 34)
                    
                    SettingMissionView(viewModel: viewModel)
                    
                    
                    Spacer()
                        .frame(height: 40)
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
    
    
    @State var isAM: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.smLightgray, lineWidth: 1)
                }
            
            VStack(alignment: .leading) {
                
                MissionListView(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 24)
                
                MakeMissionButtonView(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 24)
                
            }.padding(.horizontal, 16)
        }
        .frame(height: 402)
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
                //                viewModel.send(action: .noMissionButtonClicked)
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
                //                viewModel.send(action: .missionButtonClicked)
            } label: {
                Text("미션 만들기 완료")
                    .font(.semibold_18)
                    .foregroundColor(.smWhite)
            }
            .padding(.vertical, 17)
            .frame(width: 165)
            .background(.smRed)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

/// 보이스 레코더 리스트 뷰
private struct MissionListView: View {
    @ObservedObject private var viewModel: MakeMissionViewModel
    
    fileprivate init(viewModel: MakeMissionViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var body: some View {
        ScrollView(.vertical) {
            VStack {
                Rectangle()
                    .frame(height: 1)
            }
            
            ForEach(viewModel.missionList, id: \.self) { recordedFile in
                MissionCellView(viewModel: viewModel)
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
            
            // clearButton을 텍스트필드 안에 오버레이로 배치
            if !viewModel.mission.isEmpty {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        viewModel.send(action: .clearButtonClicked)
                    }) {
                        Image(.btnCancle)
                            .foregroundColor(.smDarkgray)
                            .padding(.trailing, 10)
                    }
                }
                .frame(height: 48) // 텍스트필드 높이와 맞추기
            }
        }
        .onSubmit {
            print("Qyd")
        }
    }
}


#Preview {
    MakeMissionView(viewModel: MakeMissionViewModel())
}

