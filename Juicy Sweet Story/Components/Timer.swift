//
//  Timer.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 25.02.2023.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject private var vm: GameViewModel
    
    var body: some View {
        Image("Time")
            .overlay {
                StrokeText(text: vm.timeRemaining.secondsToTime(), width: 2, colors: [.pink, .purple])
                    .font(.custom("Knewave-Regular", size: 23))
                    .foregroundColor(.white)
                    .shadow(color: .purple, radius: 0, x: 1, y: 1)
                    .shadow(color: .purple, radius: 0, x: -1, y: -1)
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(dev.vm)
    }
}
