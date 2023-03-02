//
//  VictoryView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 25.02.2023.
//

import SwiftUI

struct VictoryView: View {
    
    @EnvironmentObject private var vm: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var show: Bool
    @Binding var time: Int
    @Binding var bestTime: Int
    @Binding var level: Int
    
    var body: some View {
        VStack {
            
            Image("VictoryWoman")
                .resizable()
                .frame(width: getRect().height < 750 ? getRect().width / 1 : getRect().width / 1,
                       height: getRect().height < 750 ? getRect().width / 1.5 : getRect().width / 1.2,
                       alignment: .center)
            
            Image("LevelCompleted1")
                .resizable()
                .frame(width: getRect().height < 750 ? getRect().width / 1.5 : getRect().width / 1.1,
                       height: getRect().height < 750 ? getRect().width / 2.5 : getRect().width / 2.3,
                       alignment: .center)
                .offset(y: -70)
            
            VStack(spacing: 20) {
                Image("TimeFrame")
                    .overlay {
                        HStack {
                            Image("Time1")
                                .resizable()
                                .frame(width: 90, height: 40, alignment: .center)
                                .offset(x: 115)
                            
                            StrokeText(text: time.secondsToTime(), width: 2, colors: [.pink, .purple])
                                .font(.custom("Knewave-Regular", size: 32))
                                .foregroundColor(.white)
                                .shadow(color: .purple, radius: 0, x: 1, y: 1)
                                .shadow(color: .purple, radius: 0, x: -1, y: -1)
                                .offset(x: 30)
                        }
                        .offset(x: -40)
                    }
                
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
                        .offset(x: -30)
                    }
            }
            .offset(y: -50)
            
            HStack(spacing: 20) {
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    vm.showSecondLevel = false
                    vm.showThirdLevel = false
                } label: {
                    Image("HomeButton")
                }
                
                Button {
                    vm.showVictoryView = false
                    vm.startGame(level: vm.level)
                    vm.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                } label: {
                    Image("RestartButton")
                }
                
                
                if level == 1 {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        vm.showSecondLevel = true
                    } label: {
                        Image("ForwardButton")
                    }
                }
                if level == 2 {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        vm.showSecondLevel = false
                        vm.showThirdLevel = true
                    } label: {
                        Image("ForwardButton")
                    }
                }
            }
            .offset(y: -15)
        }
        .padding(.vertical, 50)
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

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLevelViewView(level: 1)
            .environmentObject(dev.vm)
    }
}
