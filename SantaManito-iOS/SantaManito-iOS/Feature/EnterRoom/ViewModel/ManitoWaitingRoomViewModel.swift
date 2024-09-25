//
//  ManitoRoomViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

//TODO: 나중에 유저에 대한 타입으로 수정
struct Participate: Hashable, Identifiable {
    var name: String
    var id = UUID()
}

extension Participate {
    static func dummy() -> [Participate] {
        return [
            Participate(name: "류희재"),
            Participate(name: "장석우"),
            Participate(name: "이영진"),
            Participate(name: "박상수"),
            Participate(name: "김상호"),
            Participate(name: "이태희"),
            Participate(name: "류희재")
        ]
        
    }
}

import Foundation
import Combine

class ManitoWaitingRoomViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
        case refreshParticipant
        case copyInviteCode
        case matchingButtonClicked //매칭하는 화면으로 넘어가서 서버통신하는게 맞겠지?
        case editRoomInfo // 방 수정하기 뷰로 넘어감
    }
    
    struct State {
        var isEnabled: Bool = false
        var isHost: Bool = true
        var description: String = ""
    }
    
    //MARK: Dependency
    
    private var enterRoomService: EnterRoomServiceType
    private var editRoomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        enterRoomService: EnterRoomServiceType,
        editRoomService: EditRoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.enterRoomService = enterRoomService
        self.editRoomService = editRoomService
        self.navigationRouter = navigationRouter
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    @Published var inviteCode: String = ""
    @Published var participateList: [Participate] = []
    @Published var roomInfo: MakeRoomInfo = MakeRoomInfo(name: "", remainingDays: 3, dueDate: Date())
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            //TODO: 참가자 정보 받아오기
            enterRoomService.getParticipate("")
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { participate in
                    owner.participateList = participate
                }).store(in: cancelBag)
            
            //TODO: room 정보 받아오기
            editRoomService.getRoomInfo(with: "")
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { roomInfo in
                    owner.roomInfo = roomInfo
                }).store(in: cancelBag)
            
            //TODO: 들어온 유저가 host인지 아닌지 서버통신
            enterRoomService.getUser("아이디 아마?")
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { isHost in
                    owner.state.isHost = isHost
                    owner.state.description = isHost 
                    ? "방장 산타는 참여자가 다 모이면 마니또 매칭을 해줘!"
                    : "방장 산타가 마니또 매칭을 할 때까지 기다려보자!"
                }).store(in: cancelBag)
            
            //TODO: 초대코드 받아오기
            enterRoomService.getInviteCode("")
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { inviteCode in
                    owner.inviteCode = inviteCode
                }).store(in: cancelBag)
            
        case .refreshParticipant:
            enterRoomService.getParticipate("")
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { participate in
                    owner.participateList = participate
                }).store(in: cancelBag)
            
        case .copyInviteCode:
            //TODO: 초대코드 복사하기
            break
            
        case .matchingButtonClicked:
//            navigationRouter.push(to: .matchRoom) -> 원래는 이거
            navigationRouter.push(to: .matchedRoom)
            
        case .editRoomInfo:
            navigationRouter.push(to: .editRoom(viewType: .editMode))
        }
    }
}
