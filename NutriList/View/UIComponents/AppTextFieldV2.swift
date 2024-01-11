//
//  AppTextFieldV2.swift
//  NutriList
//
//  Created by leonard on 2024-01-10.
//

import SwiftUI

struct AppTextFieldV2: View {
    var body: some View {
        HStack(alignment: .top, spacing:0) {
            Image(systemName: "envelope")
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
        @State private var text_g2t: String = ""
        var body: some View {
            TextField("", text: $text_g2t)
              .keyboardType(.default)
            .placeholder(when: text_g2t.isEmpty, alignment: .leading) {
                Text("Email")
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
        .textFieldStyle(TextFieldStyle_g2t())
        }
    }
    // MARK: custom structs required by some components not fully supported in SwiftUI
    struct TextFieldStyle_g2t: TextFieldStyle {
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
    AppTextFieldV2()
}
extension View {
    func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
        .opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
