//
//  AppSecureField.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct AppSecureField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 5) {
                    // Add lock icon for password field
                    Image(systemName: "lock")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18, weight: .regular))
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)

                    SecureField("", text: $text, prompt: Text(placeHolder)
                        .foregroundColor(Color("PlaceHolderGray"))
                        .font(.system(size: 17, weight: .regular)))
                        .padding()
                        .accessibilityIdentifier(placeHolder)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(1)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("LightTeal").opacity(0.65))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                }
            }
}

#Preview {
    AppSecureField(placeHolder: "password", text: .constant(""))
}
