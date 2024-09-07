//
//  SMAlertView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/8/24.
//

import SwiftUI

struct SMAlertView: View {
    
    var title: String
    var primaryAction: (title: String, action: () -> Void)
    var secondaryAction: (title: String, action: () -> Void)?
    
    
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
            
            HStack {
                Button(primaryAction.title) {
                    primaryAction.action()
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                
                if secondaryAction != nil {
                    Button(secondaryAction!.title) {
                        secondaryAction!.action()
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                }
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
    func smAlert(
        isPresented: Bool,
        title: String,
        primaryButton: (String, () -> Void),
        secondaryButton: (String, () -> Void)? = nil
    ) -> some View {
        self.overlay {
            if isPresented {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    SMAlertView(
                        title: title,
                        primaryAction: primaryButton,
                        secondaryAction: secondaryButton
                    )
                    .padding(.horizontal, 16)
                    .shadow(radius: 10)
                }
                .ignoresSafeArea()
               
            }
        }
    }
    
}

#Preview {
    SMAlertView(title: "알럿 프리뷰", primaryAction: ("확인", { }))
}
