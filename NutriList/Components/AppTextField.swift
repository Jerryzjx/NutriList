//
//  AppTextField.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct AppTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeHolder, text: $text)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTextField(placeHolder: "Email address", text: .constant(""))
    }
}
