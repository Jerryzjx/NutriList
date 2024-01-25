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
        HStack (spacing: 5) {
            Image(systemName: "envelope")
                .foregroundColor(Color.white)
                .font(.system(size: 18, weight: .regular))
                .frame(width: 44, height: 44)
            
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
            TextField("", text: $text, prompt: Text(placeHolder)
                .foregroundColor(Color("PlaceHolderGray"))
                .font(.system(size: 17, weight: .regular)))
                .padding()
                .accessibilityIdentifier(placeHolder)
                .keyboardType(.emailAddress)
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


struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTextField(placeHolder: "Email", text: .constant(""))
    }
}
