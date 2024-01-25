//
//  WelcomeText.swift
//  NutriList
//
//  Created by leonard on 2024-01-10.
//

import SwiftUI

struct WelcomeText: View {
    var body: some View {
        VStack(alignment: .leading, spacing:12) {
            Text("Welcome")
                .font(.largeTitle)
                .bold()
                .lineSpacing(0.83)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
            Text("Please login or sign up our app")
                .font(.headline)
                .fontWeight(.semibold)
                .lineSpacing(0.77)
                .foregroundColor(Color(.systemGray5))
        }
        .clipped()
        .background(.clear)
        .padding(16)
    }
}

#Preview {
    WelcomeText()
}
