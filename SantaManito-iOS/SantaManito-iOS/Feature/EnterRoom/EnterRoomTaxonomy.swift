//
//  EnterRoomTaxonomy.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/3/25.
//

import Foundation

extension AnalyticsTaxonomy {
    static let inviteCode = AnalyticsTaxonomy(
        tag: "입장하기_초대코드입력",
        tagEng: "invite_code",
        type: .page
    )
    
    static let inviteCodeEnterBtn = AnalyticsTaxonomy(
        tag: "입장하기_입장하기버튼",
        tagEng: "invite_code_enter_btn",
        type: .button
    )
    
    static let roomManittoList = AnalyticsTaxonomy(
        tag: "마니또방_목록",
        tagEng: "room_manitto_list",
        type: .page
    )
    
    static let roomEditBtn = AnalyticsTaxonomy(
        tag: "마니또방_수정하기버튼",
        tagEng: "room_edit_btn",
        type: .button
    )
    
    static let roomStartBtn = AnalyticsTaxonomy(
        tag: "마니또방_바로매칭시작하기버튼",
        tagEng: "room_start_btn",
        type: .button
    )
    
    static let roomCodeCopyBtn = AnalyticsTaxonomy(
        tag: "마니또방_초대코드복사버튼",
        tagEng: "room_code_copy_btn",
        type: .button
    )
    
    static let roomRefreshBtn = AnalyticsTaxonomy(
        tag: "마니또방_새로고침버튼",
        tagEng: "room_refresh_btn",
        type: .button
    )
}
