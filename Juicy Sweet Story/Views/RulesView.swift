//
//  RulesView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 26.02.2023.
//

import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("RulesBackButton")
                        .frame(alignment: .leading)
                }
                .padding(.horizontal)
                Spacer()
            }
            HStack {
                Image("GAME RULES")
                    .frame(alignment: .center)
            }
            Spacer()
            
            VStack(spacing: 20) {
                Image("Welcome to Juicy Sweet Story!")
                Image("MainText")
            }
            .offset(y: UIScreen.main.bounds.width / 1.15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: UIScreen.main.bounds.height / -2.6)
        .background(
            Image("Background")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(content: {
                    Image("RulesBackground")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
        ).ignoresSafeArea()
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
