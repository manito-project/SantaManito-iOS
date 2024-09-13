//
//  SMInviteCodeAlertView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

import SwiftUI

struct SMInviteCodeAlertView: View {
    
    var title: String
    var inviteCode: String
    var primaryAction: (title: String, action: () -> Void)
    
    
    var body: some View {
        
        VStack {
            Image(.graphicsSantaCircle)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .padding(.top, 30)
            
            Text(title)
                .font(.semibold_18)
                .foregroundStyle(.smDarkgray)
                .padding(.top, 20)
                .padding(.bottom, 16)
                .multilineTextAlignment(.center)
            
            Text(inviteCode)
                .font(.medium_14)
                .foregroundColor(.smWhite)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(.smRed)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            HStack {
                Button() {
                    primaryAction.action()
                } label: {
                    Text(primaryAction.title)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 60)
            }
            .font(.medium_16)
            .background(.smNavy)
            .foregroundStyle(.smWhite)
            .padding(.top, 24)
        }
        .background(.smWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
        
    }
    
}

extension View {
    func smAlertWithInviteCode(
        isPresented: Bool,
        title: String,
        inviteCode: String,
        primaryButton: (String, () -> Void),
        secondaryButton: (String, () -> Void)? = nil
    ) -> some View {
        self.overlay {
            if isPresented {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    SMInviteCodeAlertView(
                        title: title,
                        inviteCode: inviteCode,
                        primaryAction: primaryButton
                    )
                    .padding(.horizontal, 16)
                    .shadow(radius: 10)
                }
                .ignoresSafeArea()
                
            }
        }
    }
}
