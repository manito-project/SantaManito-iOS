//
//  MakeRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct MakeRoomView: View {
    
    @StateObject var viewModel: MakeRoomViewModel
    @State private var time = Date()
    
    var body: some View {
        VStack {
            SMView(padding: -100) {
                HStack {
                    InfoView()
                    
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
                    SettingRoomInfoView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 34)
                    
                    MakeRoomButtonView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 68)
            
            Button {
            } label: {
                Image(.btnBack)
            }
            
            Spacer()
                .frame(height: 47)
            
            Text("방 정보 설정")
                .font(.semibold_20)
                .foregroundColor(.smWhite)
            
            Spacer()
                .frame(height: 16)
            
            Text("언제까지 마니또 게임하게 할거야 \n내 마니또를 봐 산타 기다리잖아")
                .font(.medium_16)
                .foregroundColor(.smWhite)
                .lineSpacing(3.5)
                .lineLimit(2)
            
            Spacer()
            
        }.padding(.leading, 16)
    }
}

struct SettingRoomInfoView: View {
    @ObservedObject private var viewModel: MakeRoomViewModel
    
    fileprivate init(viewModel: MakeRoomViewModel) {
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
                Spacer()
                    .frame(height: 24)
                
                setRoomNameView
                
                Spacer()
                    .frame(height: 24)
                
                setEndDateView
                
                Spacer()
                    .frame(height: 24)
                
                setEndTimeView
                
                Spacer()
                    .frame(height: 24)
                
            }.padding(.horizontal, 16)
        }
        .frame(height: 402)
    }
    
    var setRoomNameView: some View {
        VStack(alignment: .leading) {
            Text("방이름 (최대 17자)")
                .font(.semibold_16)
                .foregroundColor(.smDarkgray)
            
            Spacer()
                .frame(height: 12)
            
            TextField(
                "",
                text: $viewModel.roomName,
                prompt: Text("재미있는 방 이름을 지어보자!").foregroundColor(.smLightgray)
            ).onChange(of: viewModel.roomName) {
                viewModel.send(action: .configRoomName($0))
            }
            .font(.medium_16)
            .foregroundColor(.smDarkgray)
            .padding(.vertical, 16)
            .padding(.leading, 12)
            .frame(height: 48)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.smLightgray, lineWidth: 1)
            }
        }
    }
    
    var setEndDateView: some View {
        VStack(alignment: .leading) {
            Text("마니또 공개일")
                .font(.semibold_16)
                .foregroundColor(.smDarkgray)
            
            Spacer()
                .frame(height: 12)
            
            HStack {
                Button {
                    //TODO: 버튼 눌럿을 때 색 변경
                    viewModel.send(action: .decreaseDuedate)
                } label: {
                    Image(viewModel.canDecreaseRemainingDays ? .btnMinus : .btnUnActivatedMinus)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .disabled(!viewModel.canDecreaseRemainingDays)
                .padding(.all, 10)
                
                Text("\(viewModel.remainingDays)일 후")
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                
                Button {
                    //TODO: 버튼 눌럿을 때 색 변경 & 비즈니스 로직
                    viewModel.send(action: .increaseDuedate)
                } label: {
                    Image(viewModel.canIncreaseRemainingDays ? .btnPlus : .btnUnActivatedPlus)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .disabled(!viewModel.canIncreaseRemainingDays)
                .padding(.all, 10)
            }
            .frame(height: 44)
            .background(content: {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.smLightbg)
            })
            
            Spacer()
                .frame(height: 10)
            
            //TODO: 글자 수 잘리는 문제 해결하기
            Text("최소 3일부터 최대 14일까지 기간을 설정할 수 있어~")
                .font(.medium_14)
                .foregroundColor(.smDarkgray)
                .lineLimit(1)
        }
    }
    
    var setEndTimeView: some View {
        
        VStack(alignment: .leading) {
            Text("마니또 공개 시간")
                .font(.semibold_16)
                .foregroundColor(.smDarkgray)
            
            Spacer()
                .frame(height: 12)
            
            HStack {
                Button{
                } label: {
                    DatePicker(
                        "DatePicker",
                        selection: $viewModel.dueDateTime,
                        displayedComponents: [.hourAndMinute] // <-
                    )
                    .onChange(of: viewModel.dueDateTime) {
                        viewModel.send(action: .configDuedateTime($0))
                    }
                    .labelsHidden()
//                    .environment(\.locale, Locale(identifier: "en_GB")) // 24시간제로 설정
                }
//                .padding(.horizontal, 14)
//                .padding(.vertical, 16)
//                .frame(width: 73, height: 44)
//                .background {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(.smLightbg)
//                }
                
                Toggle(isOn: $isAM) {
                    //TODO: AM, PM과 관련된 비즈니스 로직
                }
                .toggleStyle(MyToggleStyle(viewModel: viewModel))
                .frame(width: 122, height: 44)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.smLightbg)
                }
            }
            
            Spacer()
                .frame(height: 16)
            
            HStack {
                Spacer()
                
                SMColoredTextView(
                    fullText:"\(viewModel.remainingDays)일 후인 \(viewModel.dueDate)에\n산타 마니또 결과가 공개될거야!",
                    coloredWord: "\(viewModel.dueDate)",
                    color: .smRed
                )
                .font(.medium_14)
                .foregroundStyle(.smDarkgray)
                .lineSpacing(3)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                
                Spacer()
            }
            .frame(height: 40)
        }
    }
}

struct MakeRoomButtonView: View {
    @ObservedObject private var viewModel: MakeRoomViewModel
    
    fileprivate init(viewModel: MakeRoomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                viewModel.send(action: .noMissionButtonClicked)
            } label: {
                Text("미션없이 방 만들기")
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
                viewModel.send(action: .missionButtonClicked)
            } label: {
                Text("미션 만들기")
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



#Preview {
    MakeRoomView(viewModel: MakeRoomViewModel())
}
