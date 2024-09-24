//
//  MyPageView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: MyPageViewModel
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    MyPageView(viewModel: MyPageViewModel())
        .environmentObject(DIContainer.stub)
}
