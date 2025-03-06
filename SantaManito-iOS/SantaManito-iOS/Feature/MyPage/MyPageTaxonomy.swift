//
//  MyPageTaxonomy.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/3/25.
//

import Foundation

extension AnalyticsTaxonomy {
    static let setting = AnalyticsTaxonomy(
        tag: "설정목록",
        tagEng: "setting",
        type: .page
    )

    static let settingNameEditBtn = AnalyticsTaxonomy(
        tag: "설정목록_이름수정버튼",
        tagEng: "setting_name_edit_btn",
        type: .button
    )

    static let nameEdit = AnalyticsTaxonomy(
        tag: "이름수정",
        tagEng: "name_edit",
        type: .page
    )

    static let nameEditCompleteBtn = AnalyticsTaxonomy(
        tag: "이름수정_완료버튼",
        tagEng: "name_edit_complete_btn",
        type: .button
    )

    static let nameEditWithdrawalBtn = AnalyticsTaxonomy(
        tag: "이름수정_탈퇴버튼",
        tagEng: "name_edit_withdrawal_btn",
        type: .button
    )

    static let withdrawalPopup = AnalyticsTaxonomy(
        tag: "탈퇴모달",
        tagEng: "withdrawal_popup",
        type: .modal
    )

    static let withdrawalPopupWithdrawalBtn = AnalyticsTaxonomy(
        tag: "탈퇴모달_탈퇴하기버튼",
        tagEng: "withdrawal_popup_withdrawal_btn",
        type: .button
    )

    static let withdrawalPopupStayBtn = AnalyticsTaxonomy(
        tag: "탈퇴모달_머무르기버튼",
        tagEng: "withdrawal_popup_stay_btn",
        type: .button
    )
}

