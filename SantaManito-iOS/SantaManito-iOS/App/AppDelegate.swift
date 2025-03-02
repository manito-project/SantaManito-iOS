//
//  AppDelegate.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/1/24.
//

import UIKit
import FirebaseCore
import AmplitudeSwift


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        _ = Analytics.shared
//
//        
//        Amplitude.instance().initializeApiKey("")
//        Amplitude.instance().setUserId("")
//        Amplitude.instance().logEvent("app_start")
        
        return true
    }
    
    
    
    
}

//MARK: - 추후 FCM 구현시
//extension AppDelegate {
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      Messaging.messaging().apnsToken = deviceToken
//      print(deviceToken)
//    }
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//  //Foreground 상태에서 푸시 받을 때
//  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//    completionHandler([.banner, .sound])
//  }
//
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//    completionHandler()
//  }
//}
//
//
