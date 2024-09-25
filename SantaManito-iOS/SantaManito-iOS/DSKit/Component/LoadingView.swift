//
//  LoadingView.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/6/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

extension View {
    func loading(_ isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.2))
            }
        }
    }
}

#Preview {
    LoadingView()
}
