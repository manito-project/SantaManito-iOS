//
//  AuthView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        
        if true { //TODO: 유저인증에 성공한다면
            HomeView()
        } else {
            OnboardingView()
        }
     
    }
}

#Preview {
    AuthView()
}
