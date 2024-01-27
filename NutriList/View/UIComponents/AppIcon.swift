//
//  AppIcon.swift
//  NutriList
//
//  Created by leonard on 2024-01-10.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("NutriListIcon") 
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipped()
                .background(Color.gray.opacity(0.20))
                .cornerRadius(16)
        }
            }
}
struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
            AppIcon()
    }
}
