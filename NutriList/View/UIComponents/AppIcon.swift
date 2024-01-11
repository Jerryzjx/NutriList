//
//  AppIcon.swift
//  NutriList
//
//  Created by leonard on 2024-01-10.
//

import SwiftUI

let sw = UIScreen.main.bounds.width / 393
let sh = UIScreen.main.bounds.height / 852
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaTop = window?.safeAreaInsets.top
struct AppIcon: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
                    Image("NutriListIcon") // Replace 'AppIconImage' with the name of your duplicate icon asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .background(Color.gray.opacity(0.20))
                        .cornerRadius(16)
                }
                .frame(width: 100, height: 100, alignment: .center)
                .clipped()
                .background(.white)
                .cornerRadius(16)
                .padding(.top, safeAreaTop)
            }
}
struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppIcon()
              .ignoresSafeArea()
        }
    }
}
