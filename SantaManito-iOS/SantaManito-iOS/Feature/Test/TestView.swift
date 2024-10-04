//
//  TestView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/1/24.
//

import SwiftUI
import Combine

struct TestView: View {
    
    let cancelBag = CancelBag()
    
    var body: some View {
        
        Button("서버체크") {
            serverCheck()
        }
            
    }
        
    func serverCheck() {
        FirebaseRemoteConfigService.shared
            .getServerCheck()
            .sink { completion in
                print(completion)
            } receiveValue: { serverCheck in
                print("값 받았오🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏")
                print(serverCheck)
            }
            .store(in: cancelBag)
        
        FirebaseRemoteConfigService.shared
            .getServerCheckMessage()
            .sink { completion in
                print(completion)
            } receiveValue: { serverCheckMessage in
                print(serverCheckMessage)
            }
            .store(in: cancelBag)

    }

}

#Preview {
    TestView()
}
