//
//  GameViewModel.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 26.02.2023.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var randomPuzzles = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,14]
    @Published var currentPuzzle: Int? = nil
    @Published var timeRemaining = 180
    @Published var openLevels = UserDefaults.standard.array(forKey: UserDefaultsKey.openLevels)
    @Published var level = 1
    @Published var showVictoryView = false
    @Published var showFailedView = false
    @Published var showSecondLevel = false
    @Published var showThirdLevel = false
    
    func startGame(level: Int) {
        if level == 1 {
            timeRemaining = 180
            randomPuzzles = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,14].shuffled()
        }
        if level == 2 {
            timeRemaining = 170
            randomPuzzles = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,14].shuffled()
        }
        if level == 3 {
            timeRemaining = 160
            randomPuzzles = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,14].shuffled()
        }
    }
}
