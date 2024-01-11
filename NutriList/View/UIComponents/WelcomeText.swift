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
              .tracking(-0.41)
              .frame(width: 393, height: .infinity, alignment: .topLeading)
              .foregroundColor(Color(UIColor.systemGray4))
        }
        .frame(width: 358.8 * sw, height: 72.88 * sh, alignment: .topLeading)
        .clipped()
        .background(.clear)
        .padding(16)
    }
}

#Preview {
    WelcomeText()
}
