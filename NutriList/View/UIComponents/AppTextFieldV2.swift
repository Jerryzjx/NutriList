
//
//  AppTextFieldV2.swift
//  TextFields
//
//  Created by leonard on 2024-01-19.
//

import SwiftUI

struct AppTextFieldV2: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        HStack (spacing: 5) {
            TextField("", text: $text, prompt: Text(placeHolder)
                .foregroundColor(Color("PlaceHolderGray"))
                .font(.system(size: 17, weight: .regular)))
                .padding()
                .accessibilityIdentifier(placeHolder)
                .keyboardType(.default)
        }
        .padding(1)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("LightTeal").opacity(0.65))
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
        }
    }
}


struct AppTextFieldV2_Previews: PreviewProvider {
    static var previews: some View {
        AppTextFieldV2(placeHolder: "Enter Your Item", text: .constant(""))
    }
}
