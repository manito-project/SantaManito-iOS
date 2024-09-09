//
//  ToggleStyle.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct MyToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                // 배경뷰
                
                // 스위치 뷰
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 57, height: 36)
                    .padding(.horizontal, 4)
                    .foregroundColor(.white)
                
                // AM PM 버튼뷰
                HStack {
                    Button {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    } label: {
                        Text("AM")
                            .font(.medium_16)
                            .foregroundColor(.smDarkgray)
                            .padding(.vertical, 14)
                            .padding(.leading, 20)
                    }.disabled(!configuration.$isOn.wrappedValue)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    } label: {
                        Text("PM")
                            .font(.medium_16)
                            .foregroundColor(.smDarkgray)
                            .padding(.vertical, 14)
                            .padding(.trailing, 20)
                    }.disabled(configuration.$isOn.wrappedValue)
                }
            }
        }
    }
}
