//
//  LevelsView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 24.02.2023.
//

import SwiftUI

struct LevelsView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: GameViewModel
    @State private var levels = ["needed image", "needed image (1)", "needed image (2)", "needed image (3)", "needed image (4)", "needed image (5)", "needed image (6)", "needed image (7)", "needed image (8)", "needed image (9)", "needed image (10)", "needed image (11)", ]

    var body: some View {
        NavigationView {
            ZStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("BackButtonLevelView")
                            .frame(alignment: .leading)
                    }
                    Spacer()
                }
                HStack {
                    Image("Levels1")
                        .resizable()
                        .frame(width: 110, height: 50, alignment: .center)
                }
                Spacer()

                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]

                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(levels, id: \.self) { level in
                        if let openLevels = vm.openLevels {
                            if openLevels.contains(where: { $0 as! Int == getIndex(level) }) {
                                if getIndex(level) == 0 {
                                    NavigationLink {
                                        FirstLevelViewView(level: getIndex(level))
                                    } label: {
                                        Image(level)
                                    }
                                }
                                if getIndex(level) == 1 {
                                    NavigationLink {
                                        SecondLevelView(level: getIndex(level))
                                    } label: {
                                        Image(level)
                                    }
                                }
                                if getIndex(level) == 2 {
                                    NavigationLink {
                                        ThirdLevelView(level: getIndex(level))
                                    } label: {
                                        Image(level)
                                    }
                                }
                            } else {
                                Image(level)
                            }
                        } else {
                            if getIndex(level) == 0 {
                                NavigationLink {
                                    FirstLevelViewView(level: getIndex(level))
                                } label: {
                                    Image(level)
                                }
                            } else {
                                Image(level)
                            }
                        }
                    }
                }
                .offset(y: UIScreen.main.bounds.width / 1.28)
                
                if vm.showSecondLevel {
                    SecondLevelView(level: vm.level)
                        .offset(y: getRect().height / 2.6)
                }
                if vm.showThirdLevel {
                    ThirdLevelView(level: vm.level)
                        .offset(y: getRect().height / 2.6)
                }
            }
            .navigationBarBackButtonHidden()
            .offset(y: UIScreen.main.bounds.height / -2.6)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("Background")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            ).ignoresSafeArea()
                .onAppear {
                    if let openLevels = vm.openLevels {
                            for openLvl in openLevels {
                                guard let openLvl = openLvl as? Int else {
                                    print("return here1")
                                    return
                                }
                                if openLvl == 0 {
                                    levels.remove(at: 0)
                                    levels.insert("needed image", at: 0)
                                }
                                if openLvl == 1 {
                                    levels.remove(at: 1)
                                    levels.insert("Level1", at: 1)
                                }
                                if openLvl == 2 {
                                    levels.remove(at: 2)
                                    levels.insert("Level2", at: 2)
                                }
                            }
                    } else {
                        UserDefaults.standard.set([0], forKey: UserDefaultsKey.openLevels)
                    }
                }
                .onChange(of: vm.showThirdLevel) { _ in
                    levels.remove(at: 2)
                    levels.insert("Level2", at: 2)
                }
        }
    }
    func getIndex(_ level: String) -> Int {
        return levels.firstIndex { (level1) -> Bool in
            return level == level1
        } ?? 0
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView()
            .environmentObject(dev.vm)
    }
}
