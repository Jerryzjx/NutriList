//
//  AppTextField.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

//
//  AppTextField.swift
//  TextFields
//
//  Created by leonard on 2024-01-19.
//

import SwiftUI

struct AppTextField: View {
    var placeHolder: String
    @Binding var text: String

    var body: some View {
        TextField(placeHolder, text: $text)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .accessibilityIdentifier(placeHolder)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}


struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTextField(placeHolder: "Email", text: .constant(""))
    }
}
