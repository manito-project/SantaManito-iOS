//
//  SMInfo.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/11/24.
//

//
//  SMInfoView.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import SwiftUI

struct SMInfoView: View {
    
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 68)
                
                Button {
                } label: {
                    Image(.btnBack)
                }
                
                Spacer()
                    .frame(height: 47)
                
                Text(title)
                    .font(.semibold_20)
                    .foregroundColor(.smWhite)
                
                Spacer()
                    .frame(height: 16)
                
                Text(description)
                    .font(.medium_16)
                    .foregroundColor(.smWhite)
                    .lineSpacing(3.5)
                    .lineLimit(2)
                
                Spacer()
                
            }.padding(.leading, 16)
            
            Spacer()
            
            VStack {
                Spacer()
                    .frame(height: 80)
                
                Image(.graphicsSanta3)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 220)
            }
        }
    }
}

#Preview {
    SMInfoView(title: "방 정보 설정", description: "")
}

