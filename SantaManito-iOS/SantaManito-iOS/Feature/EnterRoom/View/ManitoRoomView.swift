//
//  ManitoRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct ManitoRoomView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack {
            SMView(padding: -100) {
                SMInfoView(
                    title: "마니또방이름최대1줄",
                    description: "오늘부터 7일 후인 12월 4일\n오전 10:00까지 진행되는 마니또"
                )
            } content: {
                
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.smLightgray, lineWidth: 1)
                            }
                        
                        ParticipateView()
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 360)
                    
                    Text("방장 산타가 마니또 매칭을 할 때까지 기다려보자!")
                        .font(.medium_14)
                        .foregroundColor(.smDarkgray)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Button("마니또 랜덤 매칭하기") {
                        viewModel.send(action: .matchingButtonClicked)
                    }
                    .smBottomButtonStyle()
                    
                    Spacer()
                        .frame(height: 40)
                }
            }
        }
    }
}

fileprivate struct ParticipateView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
    var body: some View {
        VStack{
            TitleView()
            
            ParticipateListView()
        }
    }
}

fileprivate struct TitleView: View {
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
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
    @EnvironmentObject private var viewModel: ManitoRoomViewModel
    
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

//
//
//fileprivate struct RoomInfoView: View {
//    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            DuedateInfoView()
//
//            Spacer()
//                .frame(height: 24)
//
//            if !viewModel.missionList.isEmpty {
//                MissionListView()
//            } else {
//                VStack {
//                    Text("이번에는 마니또만 매칭될거야!\n다음에는 재미있는 미션을 추가해줘!")
//                        .lineLimit(2)
//                        .lineSpacing(3)
//                        .font(.medium_14)
//                        .foregroundColor(.smDarkgray)
//                        .padding(.leading, 16)
//
//                    Spacer()
//                        .frame(height: 24)
//                }
//                .frame(height: 64)
//            }
//        }
//        .background(.smWhite)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .overlay {
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(.smLightgray, lineWidth: 1)
//        }
//        .padding(.horizontal, 16)
//    }
//}

//
//private struct MissionListView: View {
//    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
//
//    //TODO: 여기 간격이 좀 이상한데 뭐 때문에 그런지 모르겠,,
//    var body: some View {
//        VStack {
//            ScrollView(.vertical, showsIndicators: false) {
//                ForEach($viewModel.missionList) { $mission in
//                    MissionCellView(mission: $mission)
//                        .padding(.bottom, 16)
//                }
//            }
//            .frame(height: 300)
//        }
//        .padding(.horizontal, 16)
//    }
//}
//
//private struct MissionCellView: View {
//    @EnvironmentObject private var viewModel: CheckIRoomInfoViewModel
//    @Binding var mission: Mission
//
//    fileprivate init(mission: Binding<Mission>) {
//        self._mission = mission
//    }
//
//    fileprivate var body: some View {
//        ZStack {
//            HStack {
//                Text(mission.content)
//                    .font(.medium_16)
//                    .foregroundColor(.smDarkgray)
//                    .padding(.leading, 12)
//                    .padding(.vertical, 16)
//
//                Spacer()
//
//                Button(action: {
//                    viewModel.send(action: .deleteMission(mission))
//                }) {
//                    Image(.btnDelete)
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                        .padding(.trailing, 12)
//                }
//            }
//        }
//        .frame(height: 48)
//        .overlay {
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(.smLightgray, lineWidth: 1)
//        }
//    }
//}

#Preview {
    ManitoRoomView()
        .environmentObject(ManitoRoomViewModel())
}
