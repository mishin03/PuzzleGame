//
//  FailedView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 25.02.2023.
//

import SwiftUI

struct FailedView: View {
    
    @EnvironmentObject private var vm: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var show: Bool
    @Binding var bestTime: Int
    
    var body: some View {
        VStack {
            Image("FailedWoman")
                .resizable()
                .frame(width: getRect().height < 750 ? getRect().width / 1 : getRect().width / 1,
                       height: getRect().height < 750 ? getRect().width / 1.5 : getRect().width / 1.3,
                       alignment: .center)
            
            Image("levelFailed1")
                .resizable()
                .frame(width: 250, height: 160, alignment: .center)
                .offset(y: getRect().height < 750 ? -70 : -100)
            
            VStack(spacing: 20) {
                
                Image("TimeFrame")
                    .overlay {
                        HStack {
                            Image("BestTime1")
                                .resizable()
                                .frame(width: 140, height: 40, alignment: .center)
                                .offset(x: 80)
                            
                            
                            StrokeText(text: bestTime.secondsToTime(), width: 2, colors: [.pink, .purple])
                                .font(.custom("Knewave-Regular", size: 32))
                                .foregroundColor(.white)
                                .shadow(color: .purple, radius: 0, x: 1, y: 1)
                                .shadow(color: .purple, radius: 0, x: -1, y: -1)
                                .offset(x: 20)
                        }
                        .offset(x: -20)
                    }
            }
            .offset(y: -40)
            
            HStack(spacing: 20) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    vm.showSecondLevel = false
                    vm.showThirdLevel = false
                } label: {
                    Image("HomeButton")
                }
                
                Button {
                    vm.showFailedView = false
                    vm.startGame(level: vm.level)
                    vm.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                } label: {
                    Image("FailedRepeatButton")
                }
                
                Image("FailedForwardButton")
            }
            .offset(y: -15)
        }
        .padding(.vertical, 150)
        .padding(20)
        .background(.clear)
        .cornerRadius(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.65).edgesIgnoringSafeArea(.all))
        .onAppear {
            vm.timer.upstream.connect().cancel()
        }
    }
}

struct FailedView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLevelViewView(level: 1)
            .environmentObject(dev.vm)
    }
}
