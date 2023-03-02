//
//  DropViewDelegate.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 25.02.2023.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    var puzzle: Int
    @Binding var listPuzzle: [Int]
    @Binding var current: Int?
    
    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if current == nil {
            current = puzzle
        }

        let fromIndex = listPuzzle.firstIndex { (puzzle) -> Bool in
            return puzzle == current
        } ?? 0
        let toIndex = listPuzzle.firstIndex { (puzzle) -> Bool in
            return puzzle == self.puzzle
        } ?? 0

        if fromIndex != toIndex {
            withAnimation(.default) {
                let fromPuzzle = listPuzzle[fromIndex]
                listPuzzle[fromIndex] = listPuzzle[toIndex]
                listPuzzle[toIndex] = fromPuzzle
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}

