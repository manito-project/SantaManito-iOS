//
//  MatchRoomTax.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 3/10/25.
//

import Foundation

extension AnalyticsTaxonomy {
    static let manittoMatching = AnalyticsTaxonomy(
        tag: "마니또방_매칭시작",
        tagEng: "manitto_matching",
        type: .page
    )

    static let manittoHomeBtn = AnalyticsTaxonomy(
        tag: "마니또방_마니또하러가기버튼",
        tagEng: "manitto_home_btn",
        type: .button
    )

    static let manittoMatchingLottie = AnalyticsTaxonomy(
        tag: "마니또방_결과보기_로딩로띠",
        tagEng: "manitto_matching_lottie",
        type: .page
    )

    static let manittoResultMy = AnalyticsTaxonomy(
        tag: "마니또방_내결과보기",
        tagEng: "manitto_result_my",
        type: .page
    )

    static let manittoResultHomeBtn = AnalyticsTaxonomy(
        tag: "마니또방_내결과보기_홈으로가기버튼",
        tagEng: "manitto_result_home_btn",
        type: .button
    )

    static let manittoResultViewAllBtn = AnalyticsTaxonomy(
        tag: "마니또방_내결과보기_전체결과보기버튼",
        tagEng: "manitto_result_view_all_btn",
        type: .button
    )

    static let manittoResultAll = AnalyticsTaxonomy(
        tag: "마니또방_전체결과보기",
        tagEng: "manitto_result_all",
        type: .page
    )

    static let manittoResultAllHomeBtn = AnalyticsTaxonomy(
        tag: "마니또방_결과목록_홈으로가기버튼",
        tagEng: "manitto_result_all_home_btn",
        type: .button
    )

    static let manittoResultAllViewMyBtn = AnalyticsTaxonomy(
        tag: "마니또방_결과목록_내결과보기버튼",
        tagEng: "manitto_result_all_view_my_btn",
        type: .button
    )

    static let participantExitPopup = AnalyticsTaxonomy(
        tag: "참여자_방나가기확인모달",
        tagEng: "participant_exit_popup",
        type: .modal
    )

    static let participantExitPopupExitBtn = AnalyticsTaxonomy(
        tag: "참여자_방나가기확인모달_방나가기버튼",
        tagEng: "participant_exit_popup_exit_btn",
        type: .button
    )

    static let participantExitPopupStayBtn = AnalyticsTaxonomy(
        tag: "참여자_방나가기확인모달_머물기버튼",
        tagEng: "participant_exit_popup_stay_btn",
        type: .button
    )
}
