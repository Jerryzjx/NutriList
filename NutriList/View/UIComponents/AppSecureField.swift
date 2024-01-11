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
        SecureField(placeHolder, text: $text)
            .padding()
            .overlay{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        
    }
}

#Preview {
    AppSecureField(placeHolder: "password", text: .constant(""))
}
