//
//  StrokeText.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 25.02.2023.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let colors: [Color]

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gradientForeground(colors: colors)
            Text(text)
        }
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .top, endPoint: .bottom))
            .mask(self)
    }
}

struct StrokeText_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(dev.vm)
    }
}
