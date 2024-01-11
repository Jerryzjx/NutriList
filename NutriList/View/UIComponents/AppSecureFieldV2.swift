//
//  AppSecureFieldV2.swift
//  NutriList
//
//  Created by leonard on 2024-01-10.
//

import SwiftUI

struct AppSecureFieldV2: View {
    var body: some View {
        HStack(alignment: .top, spacing:0) {
            Image(systemName: "lock")
              .font(.system(size: 17, weight: .regular))
              .foregroundColor(.white)
              .frame(width: 44, height: 44)
              .clipped()
            TextField1()}
        .frame(width: 393, height: 44 * sh, alignment: .topLeading)
        .clipped()
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    struct TextField1: View {
        @State private var text_gro: String = ""
        var body: some View {
            SecureField("", text: $text_gro)
              .keyboardType(.default)
            .placeholder(when: text_gro.isEmpty, alignment: .leading) {
                Text("Password")
                  .allowsHitTesting(false)
                  .padding(8)
                // MARK: Add your custom fonts to XCode and swap these lines.
                // MARK: .font(Font.custom("SFProText-Regular", size: 17)
                  .font(Font.system(size: 17))
                  .foregroundColor(Color(#colorLiteral(red: 0.92, green: 0.92, blue: 0.96, alpha: 0.6)))
                  .opacity(0.1)
                  .zIndex(1)
            }
            // MARK: Add your custom fonts to XCode and swap these lines.
            // MARK: .font(Font.custom("SFProText-Regular", size: 17)
            .font(Font.system(size: 17))
            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .textFieldStyle(TextFieldStyle_gro())
        }
    }
    // MARK: custom structs required by some components not fully supported in SwiftUI
    struct TextFieldStyle_gro: TextFieldStyle {
        func _body(configuration: TextField<_Label>) -> some View {
            configuration
                .padding(8)
                .frame(minHeight: 44)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
        }
    }
}

#Preview {
    AppSecureFieldV2()
}

