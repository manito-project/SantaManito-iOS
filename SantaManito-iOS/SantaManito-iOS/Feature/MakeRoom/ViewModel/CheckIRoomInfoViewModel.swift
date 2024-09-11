//
//  CheckIRoomInfoViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import Foundation
import Combine

class CheckIRoomInfoViewModel: ObservableObject {

    enum Action {
        case load
        case makeRoomButtonClicked
        case deleteMission(Mission)
    }
    
    @Published var dueDateTime: Date = Date() //TODO: 서버통신으로 가져올 값 or dataBinding으로 가져올 값
    @Published var remainingDays: Int = 5 //TODO: 서버통신으로 가져올 값 or dataBinding으로 가져올 값
    
    @Published var dueDate: String = "" // 마감일자까지 남은 날짜
    @Published var missionList: [Mission] = [
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기"),
//        Mission(content: "손 잡기")
    ]

    func send(action: Action) {
        switch action {
        case .load:
            configDuedata() // 서버통신 이후 날짜로 변환하는 코드 
        case .makeRoomButtonClicked:
            break
        case .deleteMission(let mission):
            if let index = missionList.firstIndex(where: { $0.id == mission.id }) {
                missionList.remove(at: index)
            }
        }
    }
}

extension CheckIRoomInfoViewModel {
    ///마니또 공개일을 계산하는 함수
    func configDuedata() {
        // 날짜와 관련된 내용
        let currentDate = Date()
        guard let futureDate = Calendar.current.date(byAdding: .day, value: remainingDays, to: currentDate) else { return }
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: futureDate)
        guard let newDate = Calendar.current.date(from: dateComponents) else { return }
        
        
        //시간과 관련된 내용
        
        
        dueDate = newDate.toDueDate + " " + dueDateTime.toDuedateTime
    }
}
