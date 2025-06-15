//
//  BannerView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 5/31/25.
//

import SwiftUI
import GoogleMobileAds

struct AdBannerView: UIViewRepresentable {
    
    typealias UIViewType = BannerView
    
    private let adUnitID: String
    
    init(adUnitID: String) {
        self.adUnitID = adUnitID
    }
    
    func makeUIView(context: Context) -> BannerView {
        
        let banner = BannerView(adSize: AdSizeBanner)
#if RELEASE
        banner.adUnitID = adUnitID
#else
        // Debug시에는 무조건 테스트 ID를 사용해야한다.
        // 실제 유저가 아닌 개발자가 반복적으로 광고를 클릭하면, 매크로로 간주하여 구글에서 adMob계정을 정지하기 때문이다.
        // 따라서 prod환경이 아니라면 testUnitID인 "ca-app-pub-3940256099942544/2435281174"를 할당한다.
        banner.adUnitID = Self.testAdUnitID
#endif
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
}


extension AdBannerView {
    static var testAdUnitID = "ca-app-pub-3940256099942544/2435281174"
}
