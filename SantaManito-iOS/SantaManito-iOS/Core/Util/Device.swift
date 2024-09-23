//
//  Device.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/21/24.
//

import UIKit

// MARK: 디바이스의 크기, 여백 등의 정보를 담은 struct
// 참고하면 좋은 사이트 : https://kapeli.com/cheat_sheets/iOS_Design.docset/Contents/Resources/Documents/index
struct Device {
    
    private static var currentWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first { $0.isKeyWindow }
    }
    
    // MARK: 현재 활성화된 window scene 가져오기
    private static var currentWindowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
    }
    
    
    // MARK: 디바이스 width
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // MARK: 디바이스 height
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // MARK: 노치 디자인인지 아닌지
    static var isNotch: Bool {
        return Double(currentWindow?.safeAreaInsets.bottom ?? -1) > 0
    }
    
    // MARK: 상태바 높이
    static var statusBarHeight: CGFloat {
        return currentWindowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    // MARK: 네비게이션 바 높이
    static var navigationBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }
    
    // MARK: 탭 바 높이
    static var tabBarHeight: CGFloat {
        return UITabBarController().tabBar.frame.height
    }
    
    // MARK: 키보드 높이
    static var keyBoardHeight: CGFloat = 0
    
    // MARK: 디바이스의 위쪽 여백 (Safe Area 위쪽 여백)
    // ** 위쪽 여백의 전체 높이 : topInset + statusBarHeight + navigationBarHeight(존재하는 경우) **
    static var topInset: CGFloat {
        return currentWindow?.safeAreaInsets.top ?? 0
    }
    
    // MARK: 디바이스의 아래쪽 여백 (Safe Area 아래쪽 여백)
    // ** 아래쪽 여백의 전체 높이 : bottomInset + tabBarHeight(존재하는 경우) **
    static var bottomInset: CGFloat {
        return currentWindow?.safeAreaInsets.bottom ?? 0
    }
    
    static var osVersion: String {
        return UIDevice.current.systemVersion
    }
    
    static func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    // 현재 버전 가져오기
    static func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
}


