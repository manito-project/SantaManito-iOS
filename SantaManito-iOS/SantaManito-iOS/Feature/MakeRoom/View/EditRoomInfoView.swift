//
//  MakeRoomView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct EditRoomInfoView: View {

    @StateObject var viewModel: EditRoomInfoViewModel

    var body: some View {
            SMScrollView (padding: -50, topView: {
                SMInfoView(
                    title: viewModel.viewType.title,
                    description: viewModel.state.description
                )
            }, content: {
                VStack {
                    SettingRoomInfoView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 34)
                    
                    MakeRoomButtonView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 16)
            })
            .smAlert(
                isPresented: viewModel.state.isPresented,
                title: "미션없는 마니또 게임은\n친구들이 심심해할 수 있어!",
                primaryButton: ("건너뛰기", {
                    viewModel.send(action: .ignoreMissionButtonDidTap)
                }),
                secondaryButton: ("미션 만들기", {
                    viewModel.send(action: .dismissAlert)
                })
            )
            .onAppear {
                viewModel.send(action: .onAppear)
        }.navigationBarBackButtonHidden()
    }
}

fileprivate struct SettingRoomInfoView: View {
    @ObservedObject private var viewModel: EditRoomInfoViewModel
    
    fileprivate init(viewModel: EditRoomInfoViewModel) {
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
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 24)
                
                setRoomNameView
                
                Spacer()
                    .frame(height: 24)
                
                dueDateView
                
                Spacer()
                    .frame(height: 24)
                
                dueTimeView
                
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
                text: $viewModel.roomInfo.name,
                prompt: Text("재미있는 방 이름을 지어보자!").foregroundColor(.smLightgray)
            )
            .submitLabel(.done)
            .inputLimit($viewModel.roomInfo.name, maxLength: 17)
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
    
    var dueDateView: some View {
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
                    Image(viewModel.state.canDecreaseDays ? .btnMinus : .btnUnActivatedMinus)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(!viewModel.state.canDecreaseDays)
                .padding(.all, 10)
                
                Text("\(viewModel.roomInfo.totalDurationDays)일 후")
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                
                Button {
                    //TODO: 버튼 눌럿을 때 색 변경 & 비즈니스 로직
                    viewModel.send(action: .increaseDuedate)
                } label: {
                    Image(viewModel.state.canIncreaseDays ? .btnPlus : .btnUnActivatedPlus)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(!viewModel.state.canIncreaseDays)
                .padding(.all, 10)
            }
            .frame(height: 44)
            .background(content: {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.smLightbg)
            })
            
            Spacer()
                .frame(height: 10)
            
            Text("최소 3일부터 최대 14일까지 기간을 설정할 수 있어~")
                .font(.medium_14)
                .foregroundColor(.smDarkgray)
                .lineLimit(1)
        }
    }
    
    var dueTimeView: some View {
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
                        selection: $viewModel.roomInfo.dueDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .onChange(of: viewModel.roomInfo.dueDate) {
                        viewModel.send(action: .configDuedateTime($0))
                    }
                    .labelsHidden()
                }
            }
            
            Spacer()
                .frame(height: 16)
            
            HStack {
                Spacer()
                
                SMColoredTextView(
                    fullText:"\(viewModel.roomInfo.remainingDays)일 후인 \(viewModel.state.dueDate)에\n산타 마니또 결과가 공개될거야!",
                    coloredWord: "\(viewModel.state.dueDate)",
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

fileprivate struct MakeRoomButtonView: View {
    @ObservedObject private var viewModel: EditRoomInfoViewModel
    
    fileprivate init(viewModel: EditRoomInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.viewType {
        case .createMode:
            HStack(alignment: .center) {
                
                Button("미션없이 방 만들기") {
                    viewModel.send(action: .noMissionButtonDidTap)
                }
                .smBottomButtonStyle(.darkgray, .medium)
                .disabled(viewModel.state.isBottomButtonsDisabled)
                
                Spacer()
                    .frame(width: 12)
                
                Button("미션 만들기") {
                    viewModel.send(action: .missionButtonDidTap)
                }
                .smBottomButtonStyle(.red, .medium)
                .disabled(viewModel.state.isBottomButtonsDisabled)
                
                
            }
        case .editMode:
            Button("수정 완료") {
                viewModel.send(action: .editButtonDidTap)
            }.smBottomButtonStyle()
        }
        
    }
}



#Preview {
    return EditRoomInfoView(
        viewModel: EditRoomInfoViewModel(
            viewType: .createMode,
            roomService: DIContainer.stub.service.roomService,
            navigationRouter: DIContainer.stub.navigationRouter
        )
    )
    .environmentObject(DIContainer.stub)
}
