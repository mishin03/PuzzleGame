//
//  SecondLevelView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 26.02.2023.
//

import SwiftUI

struct SecondLevelView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: GameViewModel
    @State private var solvedPuzzles = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    @State private var currentPuzzle: Int?
    @State private var buttonFrames = [CGRect](repeating: .zero, count: 16)
    @State var bestTime = UserDefaults.standard.integer(forKey: UserDefaultsKey.bestTime2Level)
    @State private var gameTime = 0
    @State private var showVictoryView = false
    @State private var showFailedView = false
    
    let level: Int
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    vm.showSecondLevel = false
                } label: {
                    Image("BackButtonGameView")
                }
                Button {
                    vm.startGame(level: vm.level)
                } label: {
                    Image("RecoverButton")
                }
                if getRect().height > 750 {
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image("lvl2")
                    TimerView()
                }
            }
            .padding(.horizontal)
            .offset(y: getRect().height < 750 ? UIScreen.main.bounds.height / -2.4 : UIScreen.main.bounds.height / -2.6)
            
            Image("CandyFrame")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width < 376 ? getRect().width / 1.25 : getRect().width / 1.1,
                       height: getRect().height < 750 ? getRect().height / 2.3 : getRect().height / 2.4)
                .offset(y: getRect().height / -8.5)
            
            RoundedRectangle(cornerRadius: 60)
                .frame(width: getRect().width < 376 ? getRect().width / 1.36 : getRect().width / 1.2,
                       height: getRect().height < 750 ? getRect().height / 2.4 : getRect().height / 2.6)
                .offset(y: getRect().height / -8.4)
                .foregroundColor(.white)
                .overlay {
                    LazyVGrid(columns: columns, spacing: 4) {
                        ForEach(vm.randomPuzzles, id: \.self) { puzzle in
                            Image("2.\(puzzle)")
                                .resizable()
                                .frame(width: getRect().width < 376 ? getRect().width / 5.5 : getRect().width / 5,
                                       height: getRect().height < 750 ? getRect().height / 10 : getRect().height / 10.7)
                                .onDrag {
                                    haptic(.success)
                                    currentPuzzle = puzzle
                                    return NSItemProvider(object: String(puzzle) as NSString)
                                }
                                .onDrop(of: [.text], delegate: DropViewDelegate(puzzle: puzzle, listPuzzle: $vm.randomPuzzles, current: $currentPuzzle))
                                .onChange(of: vm.randomPuzzles) { newValue in
                                    if vm.randomPuzzles == solvedPuzzles {
                                        vm.timer.upstream.connect().cancel()

                                        UserDefaults.standard.set([0,1,2], forKey: UserDefaultsKey.openLevels)
                                        vm.openLevels = UserDefaults.standard.array(forKey: UserDefaultsKey.openLevels)

                                        gameTime = 170 - vm.timeRemaining
                                        if gameTime < bestTime {
                                            UserDefaults.standard.set(gameTime, forKey: UserDefaultsKey.bestTime2Level)
                                            bestTime = gameTime
                                        }
                                        if bestTime == 0 {
                                            bestTime = gameTime
                                            UserDefaults.standard.set(gameTime, forKey: UserDefaultsKey.bestTime2Level)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                vm.showVictoryView = true
                                            }
                                        }
                                    }
                                }
                        }
                    }
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 58))
                    .clipShape(CustomCorners(corners: [.bottomLeft, .bottomRight], radius: 58))
                    .offset(y: UIScreen.main.bounds.height / -8.4)
                }
            
            Image("2lvlExample")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width / 2, height: getRect().height / 3.5)
                .offset(y: getRect().height / 3.5)
            
            if vm.showVictoryView {
                VictoryView(show: $showVictoryView, time: $gameTime, bestTime: $bestTime, level: $vm.level)
            }
            
            if vm.showFailedView {
                FailedView(show: $showFailedView, bestTime: $bestTime)
                    .padding(.vertical, 30)
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("Background")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        ).ignoresSafeArea()
            .onAppear {
                vm.showVictoryView = false
                vm.showFailedView = false
                vm.level = 2
                vm.startGame(level: vm.level)
                vm.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            .onReceive(vm.timer) { value in
                if self.vm.timeRemaining > 0 {
                    self.vm.timeRemaining -= 1
                } else {
                    withAnimation {
                        showFailedView = true
                        vm.showFailedView = true
                    }
                }
                if vm.showSecondLevel {
                    vm.timeRemaining += 1
                }
            }
    }
}

struct SecondLevelView_Previews: PreviewProvider {
    static var previews: some View {
        SecondLevelView(level: 2)
            .environmentObject(dev.vm)
    }
}
