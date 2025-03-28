//
//  MakeRoomTaxonomy.swift
//  SantaManito-iOS
//

//  Created by 류희재 on 3/10/25.


import Foundation

extension AnalyticsTaxonomy {
    static let makeRoomInformation = AnalyticsTaxonomy(
        tag: "방만들기_방정보설정",
        tagEng: "make_room_information",
        type: .page
    )

    static let makeRoomInformationNoMissionBtn = AnalyticsTaxonomy(
        tag: "방만들기_방정보설정_미션없이방만들기버튼",
        tagEng: "make_room_information_no_mission_btn",
        type: .button
    )

    static let makeRoomMissionBtn = AnalyticsTaxonomy(
        tag: "방만들기_방정보설정_미션만들기버튼",
        tagEng: "make_room_mission_btn",
        type: .button
    )

    static let makeMission = AnalyticsTaxonomy(
        tag: "방만들기_미션만들기",
        tagEng: "make_mission",
        type: .page
    )

    static let makeMissionPlusBtn = AnalyticsTaxonomy(
        tag: "방만들기_미션만들기_미션추가버튼",
        tagEng: "make_mission_plus_btn",
        type: .button
    )

    static let makeMissionMinusBtn = AnalyticsTaxonomy(
        tag: "방만들기_미션만들기_미션삭제버튼",
        tagEng: "make_mission_minus_btn",
        type: .button
    )

    static let makeMissionSkipBtn = AnalyticsTaxonomy(
        tag: "방만들기_미션만들기_건너뛰기버튼",
        tagEng: "make_mission_skip_btn",
        type: .button
    )

    static let makeMissionCompleteBtn = AnalyticsTaxonomy(
        tag: "방만들기_미션만들기_미션만들기완료버튼",
        tagEng: "make_mission_complete_btn",
        type: .button
    )

    static let makeComplete = AnalyticsTaxonomy(
        tag: "방만들기_방정보확인",
        tagEng: "make_complete",
        type: .page
    )

    static let makeCompleteMissionMinusBtn = AnalyticsTaxonomy(
        tag: "방만들기_방정보확인_미션삭제버튼",
        tagEng: "make_complete_mission_minus_btn",
        type: .button
    )

    static let makeCompleteBtn = AnalyticsTaxonomy(
        tag: "방만들기_방정보확인_방만들기버튼",
        tagEng: "make_complete_btn",
        type: .button
    )

    static let makeCodeComplePopup = AnalyticsTaxonomy(
        tag: "방만들기_초대코드모달",
        tagEng: "make_code_comple_popup",
        type: .modal
    )

    static let makeCodeCopyBtn = AnalyticsTaxonomy(
        tag: "방만들기_초대코드모달_복사버튼",
        tagEng: "make_code_copy_btn",
        type: .button
    )

    static let missionNoPopup = AnalyticsTaxonomy(
        tag: "방만들기_미션미설정확인모달",
        tagEng: "mission_no_popup",
        type: .modal
    )

    static let missionNoPopupSkipBtn = AnalyticsTaxonomy(
        tag: "방만들기_미션미설정확인모달_건너뛰기버튼",
        tagEng: "mission_no_popup_skip_btn",
        type: .button
    )

    static let missionNoPopupMissionBtn = AnalyticsTaxonomy(
        tag: "방만들기_미션미설정확인모달_미션만들기버튼",
        tagEng: "mission_no_popup_mission_btn",
        type: .button
    )

    static let missionSkipPopup = AnalyticsTaxonomy(
        tag: "방만들기_작성중미션스킵모달",
        tagEng: "mission_skip_popup",
        type: .modal
    )

    static let missionSkipPopupSkipBtn = AnalyticsTaxonomy(
        tag: "방만들기_작성중미션스킵모달_나가기버튼",
        tagEng: "mission_skip_popup_skip_btn",
        type: .button
    )

    static let missionSkipPopupMissionBtn = AnalyticsTaxonomy(
        tag: "방만들기_작성중미션스킵모달_미션만들기버튼",
        tagEng: "mission_skip_popup_mission_btn",
        type: .button
    )

    static let leaderExitPopup = AnalyticsTaxonomy(
        tag: "방장나가기확인모달",
        tagEng: "leader_exit_popup",
        type: .modal
    )

    static let leaderExitPopupExitBtn = AnalyticsTaxonomy(
        tag: "방장나가기확인모달_방나가기버튼",
        tagEng: "leader_exit_popup_exit_btn",
        type: .button
    )

    static let leaderExitPopupStayBtn = AnalyticsTaxonomy(
        tag: "방장나가기확인모달_머물기버튼",
        tagEng: "leader_exit_popup_stay_btn",
        type: .button
    )

    static let roomEdit = AnalyticsTaxonomy(
        tag: "마니또방_방정보수정",
        tagEng: "room_edit",
        type: .page
    )
    
    static let roomEditCompleteBtn = AnalyticsTaxonomy(
        tag: "마니또방_방정보수정_수정완료버튼",
        tagEng: "room_edit_complete_btn",
        type: .button
    )
}
