//
//  SplashView.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
            Image("spoonacular_logo")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.5)
        }
    }
}
