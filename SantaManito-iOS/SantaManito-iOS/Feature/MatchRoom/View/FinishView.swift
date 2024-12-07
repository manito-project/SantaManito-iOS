//
//  FinishView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import SwiftUI

struct FinishView: View {
    @StateObject var viewModel: FinishViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.smNavy
            
            VStack {
                FinishTitleView(viewModel: viewModel)
                
                if viewModel.state.viewType == .me {
                    FinishResultView(viewModel: viewModel)
                } else {
                    FinishAllResultView(viewModel: viewModel)
                }
                
                
                Spacer()
                    .frame(height: 76)
                
                FinishButtonView(viewModel: viewModel)
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .smAlert(
            isPresented: viewModel.state.exitRoomAlertIsPresented,
            title: "한 번 나가면 마니또 방에 다시\n들어올 수 없어. 그래도 괜찮아?",
            primaryButton: ("방 나가기", {viewModel.send(action: .alert(.exitRoom) )}),
            secondaryButton: ("방에 머물기", { viewModel.send(action: .alert(.cancel)) })
        )
        .onAppear {
            viewModel.send(action: .onAppear)
        }
    }
}

fileprivate struct FinishTitleView: View {
    @ObservedObject private var viewModel: FinishViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: FinishViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(.btnBack)
                }
                
                Spacer()
                    .frame(height: 50)
                
                Text(viewModel.state.roomName)
                    .font(.semibold_20)
                    .foregroundColor(.smWhite)
                
                Spacer()
                    .frame(height: 16)
                
                Text(viewModel.state.description)
                    .font(.medium_16)
                    .foregroundColor(.smWhite)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button {
                    viewModel.send(action: .deleteRoomButtonDidTap)
                } label: {
                    Image(.icTrash)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                    .frame(height: 96)
                
                Image(.graphics3Friends)
                    .resizable()
                    .frame(width: 120, height: 57)
                    .padding(.trailing, 14)
            }
        }
    }
}

fileprivate struct FinishResultView: View {
    @ObservedObject private var viewModel: FinishViewModel
    
    init(viewModel: FinishViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 24)
                
                Text("나를 챙겨준 산타 마니또")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                    .lineSpacing(2)
                
                Spacer()
                    .frame(height: 16)
                
                HStack {
                    Spacer()
                    
                    Text(viewModel.state.mySanta.santa.username)
                        .font(.semibold_24)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(.smNavy)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 30)
                
                Text("마니또가 나에게 수행한 미션")
                    .font(.semibold_18)
                    .foregroundColor(.smDarkgray)
                
                Spacer()
                    .frame(height: 15)
                
                
                Text(viewModel.state.mySantaMission) 
                    .font(.medium_16)
                    .foregroundColor(.smDarkgray)
                    .padding(.horizontal, 11)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, minHeight: 98, alignment: .top)
                    .background(.smLightbg)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Image(.graphicsTree)
                        .resizable()
                        .frame(width: 54, height: 73)
                    
                    Spacer()
                    
                    Image(.graphicsTree)
                        .resizable()
                        .frame(width: 54, height: 73)
                }
            }
            .padding(.horizontal, 16)
            .background(.smWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

fileprivate struct FinishAllResultView: View {
    @ObservedObject private var viewModel: FinishViewModel
    
    init(viewModel: FinishViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 24)
                
                Text("총 \(viewModel.state.members.count)명")
                    .font(.semibold_16)
                    .foregroundColor(.smDarkgray)
                    .padding(.leading, 16)
                
                Spacer()
                    .frame(height: 24)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .foregroundColor(.smLightgray)
                
                Spacer()
                    .frame(height: 21)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.state.members, id: \.self) { member in
                        ParticipateCellView(member: member)
                            .padding(.bottom, 16)
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
            }
            .frame(height: 360)
            .background(.smWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

fileprivate struct ParticipateCellView: View {
    private let member: Member
    
    init(member: Member) {
        self.member = member
    }
            
    //TODO: 가운데 정렬을 맞춰야 할지 아니면 길이를 상수로 때려박지 말아야될지
    var body: some View {
        HStack {
            Text(member.santa.username)
                .font(.semibold_12)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 36)
                .frame(minWidth: 133, minHeight: 36)
                .multilineTextAlignment(.center)
                .background(.smNavy)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Spacer()
                .frame(width: 14)
            
            Image(.icArrow)
                .resizable()
                .frame(width: 16, height: 16)
            
            Spacer()
                .frame(width: 14)
            
            Text(member.manitto?.username ?? "")
                .font(.semibold_12)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 36)
                .frame(minWidth: 133, minHeight: 36)
                .multilineTextAlignment(.center)
                .background(.smGreen)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .frame(height: 36)
    }
}

fileprivate struct FinishButtonView: View {
    @ObservedObject private var viewModel: FinishViewModel
    @Environment(\.dismiss) var dismiss
    init(viewModel: FinishViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                dismiss()
            } label: {
                Text("홈으로 가기")
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
                viewModel.send(action: .toggleViewTypeButtonDidTap)
            } label: {
                Text(viewModel.state.viewType.buttonText)
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
    let container = DIContainer.stub
    return FinishView(
        viewModel: FinishViewModel(
            roomService: container.service.roomService,
            navigationRouter: container.navigationRouter,
            roomInfo: .stub1
        )
    )
}
