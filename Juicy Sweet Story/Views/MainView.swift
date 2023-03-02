//
//  MainView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 24.02.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var vm: GameViewModel
    @State private var buttons = ["PlayButton", "GameRulesButton", "SettingsButton", "PrivacyPolicyButton"]

    var body: some View {
        NavigationView {
            ZStack {
                Image("Candy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: getRect().height < 750 ? getRect().width / 1.2 : getRect().width / 1.1,
                           height: getRect().width / 1.2)
                    .offset(y: getRect().height / -3.7)

                    VStack(spacing: 15) {
                        NavigationLink {
                            LevelsView()
                                .navigationBarHidden(true)
                        } label: {
                            Image(buttons[0])
                        }
                        NavigationLink {
                            RulesView()
                                .navigationBarHidden(true)
                        } label: {
                            Image(buttons[1])
                        }
                        NavigationLink {
                            SettingsView()
                                .navigationBarHidden(true)
                        } label: {
                            Image(buttons[2])
                        }
                        NavigationLink {

                        } label: {
                            Image(buttons[3])
                        }
                    }
                    .offset(y: getRect().height < 750 ? getRect().height / 6 : getRect().height / 9)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("Background")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            ).ignoresSafeArea()
        }
        .onAppear {
            vm.showVictoryView = false
            vm.showFailedView = false
            if let openLevels = vm.openLevels {
                    print(openLevels)
            } else {
                UserDefaults.standard.set([0], forKey: UserDefaultsKey.openLevels)
                vm.openLevels = UserDefaults.standard.array(forKey: UserDefaultsKey.openLevels)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(dev.vm)
    }
}
